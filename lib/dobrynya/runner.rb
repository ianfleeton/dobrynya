require 'trollop'
require_relative 'importer'
require_relative 'exporter'

module Dobrynya
  class Runner
    attr_reader :opts

    def initialize(argv)
      @opts = Trollop::options(argv) do
        opt :base,   'Zmey website URL', short: 'b', type: :string
        opt :export, 'Directory to export', short: 'e', type: :string
        opt :import, 'Directory to import', short: 'i', type: :string
        opt :key,    'API key', short: 'k', type: :string
      end
    end

    def run
      importer_or_exporter.new(opts).run
    end

    def importer_or_exporter
      if opts[:import]
        Importer
      elsif opts[:export]
        Exporter
      else
        raise "Specify an import or export directory"
      end
    end
  end
end
