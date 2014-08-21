require 'curl'
require 'json'

module Dobrynya
  class CurlHelper
    def initialize(base, key)
      @base, @key = base, key
    end

    def download(remote, local)
      puts "downloading #{remote} to #{local}"
      @c = Curl.get(remote) do |c|
        c.http_auth_types = :basic
        c.username = @key
        c.password = ''
      end
      puts "#{@c.status} (#{local})"
      if @c.status == '200 OK'
        File.open(local, 'w') {|f| f.write(@c.body_str)}
      end
    end

    def json
      JSON.parse(@c.body_str)
    end

    def status
      @c.status
    end
  end
end
