require "spec_helper"

RSpec.describe Imdb::Datasets::Client do

  describe "#fetch_datasets" do
    let(:datasets) { ["title.basics"] }

    it "creates a directory if it does not exist" do
      aws_client = instance_double(Aws::S3::Client)
      expect(Aws::S3::Client).to receive(:new).and_return(aws_client)
      expect(aws_client).to receive(:get_object).with(hash_including(
        bucket: "imdb-datasets",
        request_payer: "requester",
        response_target: "imdb_datasets/title.basics.tsv.gz",
        key: "documents/v1/current/title.basics.tsv.gz",
      )).once
      subject.fetch_datasets(datasets: datasets)
      expect(File.exists?('imdb_datasets')).to be true
    end
  end
end

