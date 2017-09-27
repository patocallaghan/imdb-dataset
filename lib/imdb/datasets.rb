require "imdb/datasets/version"
require "imdb/datasets/client"

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
      def fetch
        Client.fetch_datasets(datasets: DATASETS)
      end
    end
  end
end
