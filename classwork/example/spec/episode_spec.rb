require "episode"

RSpec.describe "Episode" do
  describe "publishing" do
    context "when new" do
      it "could be published" do
        episode = Episode.new
        episode.status = "new"

        episode.publish

        expect(episode.status).to eq("published")
      end
    end

    context "when pubhlished" do
    end
  end
end