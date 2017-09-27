require "spec_helper"

RSpec.describe Imdb::Datasets do
  it "has a version number" do
    expect(Imdb::Datasets::VERSION).not_to be nil
  end

  it "#fetch" do
    expect(Aws::S3::Client).to receive(:new).and_call_original
    expect_any_instance_of(Aws::S3::Client).to receive(:get_object).with(hash_including(
      bucket: "imdb-datasets",
      request_payer: "requester"
    )).exactly(6).times
    expect_any_instance_of(Aws::S3::Client).to receive(:get_object).with(hash_including(
      response_target: "imdb_datasets/title.basics.tsv.gz",
      key: "documents/v1/current/title.basics.tsv.gz",
    )).at_most(:once)
    expect_any_instance_of(Aws::S3::Client).to receive(:get_object).with(hash_including(
      response_target: "imdb_datasets/title.crew.tsv.gz",
      key: "documents/v1/current/title.crew.tsv.gz",
    )).at_most(:once)
    expect_any_instance_of(Aws::S3::Client).to receive(:get_object).with(hash_including(
      response_target: "imdb_datasets/title.episode.tsv.gz",
      key: "documents/v1/current/title.episode.tsv.gz",
    )).at_most(:once)
    expect_any_instance_of(Aws::S3::Client).to receive(:get_object).with(hash_including(
      response_target: "imdb_datasets/title.principals.tsv.gz",
      key: "documents/v1/current/title.principals.tsv.gz",
    )).at_most(:once)
    expect_any_instance_of(Aws::S3::Client).to receive(:get_object).with(hash_including(
      response_target: "imdb_datasets/title.ratings.tsv.gz",
      key: "documents/v1/current/title.ratings.tsv.gz",
    )).at_most(:once)
    expect_any_instance_of(Aws::S3::Client).to receive(:get_object).with(hash_including(
      response_target: "imdb_datasets/name.basics.tsv.gz",
      key: "documents/v1/current/name.basics.tsv.gz",
    )).at_most(:once)
    subject.fetch
  end
end
