require "rails_helper"

RSpec.describe OauthJwt do
  before do
    @site = global_application_instance.site
    @user = FactoryBot.create(:user)
  end
  describe "issue_token" do
    it "issues a token" do
      token = OauthJwt.issue_token(
        app_callback_url: "https://www.example.com/callback",
        site: @site,
        application_instance: global_application_instance,
        user: @user,
        oauth_complete_url: "https://www.example.com/complete",
      )
      expect(token).to be_truthy
    end
  end

  describe "decode_token" do
    before do
      @token = OauthJwt.issue_token(
        app_callback_url: "https://www.example.com/callback",
        site: @site,
        application_instance: nil,
        user: @user,
        oauth_complete_url: "https://www.example.com/complete",
      )
    end
    it "decodes a token" do
      decoded = OauthJwt.decode_token(@token)[0]
      expect(decoded["site_id"]).to eq(@site.id)
      expect(decoded["application_instance_id"]).to eq(nil)
      expect(decoded["user_id"]).to eq(@user.id)
      expect(decoded["oauth_complete_url"]).to eq("https://www.example.com/complete")
      expect(decoded["app_callback_url"]).to eq("https://www.example.com/callback")
    end
    it "raises if the site secret changes" do
      @site.update(secret: "somethingelse")
      expect {OauthJwt.decode_token(@token)}.
        to raise_error(JWT::VerificationError)
    end
    it "raises if the token is bad" do
      expect {OauthJwt.decode_token("nothinggood")}.
        to raise_error(JWT::DecodeError)
    end
  end
end
