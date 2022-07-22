require "rails_helper"

describe AssetFinder do
  before do
    @asset_host = "https://cdn.example.com"
  end

  describe "get_src" do
    context "custom question" do
      it "generates a path to the requested asset" do
        src = AssetFinder.get_src("datacamp.js")
        expect(src).to match(/\/assets\/datacamp.*\.js/)
      end
      it "generates a url to the requested asset based on rails host configuration" do
        config = double("config", action_controller: double({ asset_host: @asset_host }))
        expect(Rails).to receive("configuration").and_return(config)
        src = AssetFinder.get_src("datacamp.js")
        expect(src).to match(/https:\/\/cdn\.example\.com\/assets\/datacamp.*\.js/)
      end
      it "generates url based on provided host" do
        src = AssetFinder.get_src("datacamp.js", @asset_host)
        expect(src).to match(/https:\/\/cdn\.example\.com\/assets\/datacamp.*\.js/)
      end
    end
  end
end
