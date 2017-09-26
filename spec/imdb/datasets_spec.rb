require "spec_helper"

RSpec.describe Imdb::Datasets do
  it "has a version number" do
    expect(Imdb::Datasets::VERSION).not_to be nil
  end

  it "#fetch" do
    expect(subject.fetch).to eq(true)
  end
end
