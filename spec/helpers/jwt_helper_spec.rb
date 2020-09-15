require "rails_helper"

describe JwtHelper do
  describe "jwt_token" do
    helper do
      def current_application_instance
        nil
      end
    end

    before do
      setup_application_instance(mock_helper: false)
    end

    it "generates a new jwt token" do
      expect(helper).to receive("signed_in?").and_return(true)
      expect(helper).to receive(:current_user).and_return(double(id: 1))
      allow(helper).to receive(:current_application_instance).and_return(@application_instance)
      result = helper.jwt_token
      expect(result).to be
    end
  end
end
