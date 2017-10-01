module Imdb
  module Datasets
    module FilesProcessor
      INPUT_FILE_EXTENSION = ".tsv.gz"
      OUTPUT_FILE_EXTENSION = ".tsv"
      DIRECTORY = "imdb_datasets/"

      class << self
        def process(filenames: [])
          filenames.each { |filename| process_single_file(filename) }
        end

        def process_single_file(filename)
          input = "#{DIRECTORY}#{filename}#{INPUT_FILE_EXTENSION}"
          output = "#{DIRECTORY}#{filename}#{OUTPUT_FILE_EXTENSION}"
          File.open(output, 'w') do |file|
            Zlib::GzipReader.open(input) { |gz| file.write(gz.read) }
            File.delete(input) if File.exists?(input)
          end
        rescue => e
          logger = Logger.new(STDOUT)
          logger.error("Imdb::Datasets::FilesProcessor: Error processing file #{e.message}")
          File.delete(output)
        end
      end
    end
  end
end

