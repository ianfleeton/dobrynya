require 'minitest/autorun'
require 'securerandom'
require_relative '../../lib/dobrynya/exporter'

module Dobrynya
  describe Exporter do
    describe '#run' do
      it 'makes the directories if needed' do
        dir = "/tmp/#{SecureRandom.hex}"
        e = Exporter.new(export: dir, base: 'http://example.org')
        e.run
        File.exist?(dir).must_be :==, true
        ['images', 'orders', 'payments', 'products', 'users'].each do |subdir|
          File.exist?(File.join([dir, subdir])).must_be :==, true
        end
        FileUtils.rm_rf(dir)
      end
    end
  end
end
