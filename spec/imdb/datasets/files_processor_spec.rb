require "spec_helper"

RSpec.describe Imdb::Datasets::FilesProcessor do

  describe "#process" do
    project_root_dir = Imdb::Datasets.root.gsub(/\/lib/, "")
    spec_dir = File.join project_root_dir, "spec"
    fixtures_dir = File.join spec_dir, "fixtures"
    output_dir = File.join project_root_dir, "imdb_datasets"
    fixture_file = File.join fixtures_dir, "title.basics.tsv.gz"
    copied_file = File.join output_dir, "title.basics.tsv.gz"
    output_file = File.join output_dir, "title.basics.tsv"

    before do
      FileUtils.cp(fixture_file, output_dir)
    end

    after do
      File.delete(output_file)
    end

    it "processes the .gz file correctly" do
      expect(File.exists?(copied_file)).to be true
      expect(File.exists?(output_file)).to be false
      subject.process(filenames: ["title.basics"])
      expect(File.exists?(copied_file)).to be false
      expect(File.exists?(output_file)).to be true
    end
  end
end


