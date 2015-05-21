module Metacrunch
  module UBPB
    class ImportAlephCommand < Metacrunch::Command

      def pre_perform
        @uri       = options[:uri]
        @log       = options[:log]
        @bulk_size = options[:bulk_size]
      end

      def perform
        if params.empty?
          shell.say "No files found", :red
        else
          import_files(params)
        end
      end

    private

      def import_files(files)
        elasticsearch = Metacrunch::Elasticsearch::Writer.new(@uri, bulk_size: @bulk_size, log: @log)

        file_reader = Metacrunch::FileReader.new(files)
        file_reader.each do |_file|
          mab = _file.contents
          id  = mab.match(/<identifier>aleph-publish:(\d+)<\/identifier>/){ |m| m[1] }
          raise RuntimeError, "Document has no ID." unless id

          id  = "PAD_ALEPH#{id}"
          mab = mab.force_encoding("utf-8")

          elasticsearch.write({id: id, data: mab})
        end
      ensure
        elasticsearch.close if elasticsearch
      end

    end
  end
end
