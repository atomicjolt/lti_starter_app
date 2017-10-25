require "rails_helper"

describe ApplicationHelper do
  describe "application_base_url" do
    it "adds a trailing / onto the request's base url" do
      expect(helper.application_base_url).to be
    end
  end
end
