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
        File.exist?(File.join([dir, 'orders'])).must_be :==, true
        File.exist?(File.join([dir, 'payments'])).must_be :==, true
        File.exist?(File.join([dir, 'products'])).must_be :==, true
        FileUtils.rm_rf(dir)
      end
    end
  end
end
