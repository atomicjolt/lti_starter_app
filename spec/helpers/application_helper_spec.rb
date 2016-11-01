require "rails_helper"

describe ApplicationHelper do

  describe "#canvas_url" do
    it "provides the canvas url from settings" do
      expect(helper.canvas_url).to eq(Rails.application.secrets.canvas_url)
    end
  end

  describe "application_base_url" do
    it "adds a trailing / onto the request's base url" do
      expect(helper.application_base_url).to be
    end
  end

  describe "jwt_token" do
    it "generates a new jwt token" do
      expect(helper).to receive("signed_in?").and_return(true)
      expect(helper).to receive(:current_user).and_return(double(id: 1))
      result = helper.jwt_token
      expect(result).to be
    end
  end

end