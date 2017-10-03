require "imdb/datasets/version"
require "imdb/datasets/client"
require "imdb/datasets/files_processor"
require "pry"

module Imdb
  module Datasets
    DATASETS = %w(
      title.basics
      title.crew
      title.episode
      title.principals
      title.ratings
      name.basics
    )

    class << self
      def root
        File.dirname __dir__
      end

      def fetch(datasets: DATASETS)
        verified_datasets = reject_nonexistent_datasets(datasets)
        Client.fetch_datasets(datasets: verified_datasets)
        FilesProcessor.process(filenames: verified_datasets)
      end

      def reject_nonexistent_datasets(datasets)
        datasets.select { |dataset| DATASETS.include?(dataset) }
      end
    end
  end
end
