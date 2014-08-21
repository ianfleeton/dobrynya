require 'minitest/autorun'
require_relative '../../lib/dobrynya/runner'

module Dobrynya
  describe Runner do
    describe '#initialize' do
      it 'accepts an array' do
        Runner.new([]).must_be_instance_of Runner
      end

      it 'sets opts' do
        url = 'http://example.org'
        key = 'secret'
        dir = '/tmp'
        runner = Runner.new([
          '-b', url,
          '-i', dir,
          '-k', key,
        ])
        runner.opts[:base].must_equal url
        runner.opts[:key].must_equal key
        runner.opts[:import].must_equal dir
      end
    end

    describe '#importer_or_exporter' do
      describe 'with directory to import' do
        it 'returns Importer' do
          o = Runner.new(['-i', '/tmp']).importer_or_exporter
          o.must_be :==, Importer
        end
      end

      describe 'with directory to export' do
        it 'returns Exporter' do
          o = Runner.new(['-e', '/tmp']).importer_or_exporter
          o.must_be :==, Exporter
        end
      end

      describe 'with neither directory' do
        it 'raises' do
          o = Runner.new []
          proc { o.importer_or_exporter }.must_raise(RuntimeError)
        end
      end
    end
  end
end
