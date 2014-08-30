require 'fileutils'
require_relative 'curl_helper'

module Dobrynya
  class Exporter
    attr_reader :opts

    def initialize(opts)
      @opts = opts
    end

    def run
      mkdirs

      background_process(2, ['orders', 'payments', 'products', 'users']) do |collection|
        begin
          export_collection(collection)
        rescue => e
          $stderr.puts "Failed to download #{collection}: #{e}"
        end
      end
    end

    def export_collection(collection)
      c = download(endpoint(collection), '', '.json')
      background_process(6, c.json[collection]) do |item|
        download(item['href'], collection, '.json')
      end
    end

    def mkdirs
      FileUtils.mkdir(opts[:export])
      ['orders', 'payments', 'products', 'users'].each do |subdir|
        FileUtils.mkdir(File.join([opts[:export], subdir]))
      end
    end

    def endpoint(partial)
      "#{opts[:base]}/api/admin/#{partial}"
    end

    def download(endpoint, subdir = '', append = '')
      helper = CurlHelper.new(opts[:base], opts[:key])
      helper.download(endpoint, File.join(opts[:export], subdir, "#{File.basename(endpoint)}#{append}"))
      helper
    end

    private

      def background_process(concurrency, items)
        queue = Queue.new
        items.each { |item| queue << item }
        threads = []

        concurrency.times do
          threads << Thread.new do
            until queue.empty?
              item = queue.pop(true) rescue nil
              yield item
            end
          end
        end

        threads.each(&:join)
      end
  end
end
