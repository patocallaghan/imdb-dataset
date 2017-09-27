require "imdb/datasets/version"
require "imdb/datasets/client"
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
      def fetch(datasets: DATASETS)
        verified_datasets = reject_nonexistent_datasets(datasets)
        Client.fetch_datasets(datasets: verified_datasets)
      end

      def reject_nonexistent_datasets(datasets)
        datasets.select { |dataset| DATASETS.include?(dataset) }
      end
    end
  end
end
