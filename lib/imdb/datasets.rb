require "imdb/datasets/version"
require 'aws-sdk-s3'

module Imdb
  module Datasets
    AWS_BUCKET = "imdb-datasets"
    AWS_ENDPOINT = "documents/v1/current/"
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
        client = Aws::S3::Client.new(
          region: 'us-east-1',
          access_key_id: ENV["AWS_ACCESS_KEY_ID"],
          secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
          :logger => Logger.new($stdout),
          :http_wire_trace => true
        )
        DATASETS.each do |dataset|
          filename = "#{dataset}.tsv.gz"
          client.get_object({
            response_target: "imdb_datasets/#{filename}",
            bucket: AWS_BUCKET,
            key: "#{AWS_ENDPOINT}#{filename}",
            request_payer: "requester",
          })
        end
      end
    end
  end
end
