require "rails_helper"

describe JwtHelper do
  describe "jwt_token" do
    it "generates a new jwt token" do
      expect(helper).to receive("signed_in?").and_return(true)
      expect(helper).to receive(:current_user).and_return(double(id: 1))
      result = helper.jwt_token
      expect(result).to be
    end
  end
end
