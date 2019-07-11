require "rails_helper"

RSpec.describe LtiAdvantage::Config do
  before do
    @domain = "www.example.com"
    @launch_url = "https://#{@domain}/lti_launches"
    @import_url = "https://#{@domain}/api/ims_imports"
    @export_url = "https://#{@domain}/api/ims_exports"
    @basic_config = {
      secure_launch_url: @launch_url,
      launch_url: @launch_url,
      export_url: @export_url,
      import_url: @import_url,
      title: "Atomic LTI test",
      description: "This is the test application for the Atomic LTI engine",
      icon: "oauth_icon.png",
      domain: @domain,
    }
    @icon_url = "https://#{@basic_config[:domain]}/#{@basic_config[:icon]}"
    @jwk = {
      "kty"=>"RSA",
      "e"=>"AQAB",
      "n"=>"0VjK0uLhrT_-jFpih7mL2e78y_fd5ulEOJUU8eCFcEPdArKSlbyqf1kuBy29iuXcK3IxYWLQ6Wra3PuUKie7qW2_XvcOxG9vpe4jQtTGxQ8x2CwRfS4WYp3ii7WzTugMvG0UXxJlgFeHxDjABzBYRDkkT9GLpa2oMXAnIlyEUE12tAc-J3-plqPE-28hhlWpBPNQ0sgWfHme82qhrOQRNMJWIYqlHaoGk4WefIC8FHL39CkIMjbgwUSRX2oNXij4WW-9hGBW2e2qPXAfO8QSrwYdJCApJv7-VBHGsLGdNhvGBfFsI-Satt4L6WLNphfdL5LzN7c3Xr7WbCu2aRrkJw",
      "kid"=>"_iss3-5vv94LDsvE_zQY3gtSOQNhA6z1HdwxGZvhZ3c",
      "use"=>"sig",
      "alg"=>"RS256",
    }
  end

  describe "lti_to_lti_advantage" do
    it "converts lti configuration into lti advantage" do
      json = described_class.json(@jwk, @basic_config)
      expect(json).to be_present
      basic_json = <<~json
        {

        }
      json
      expect(json).to eq(basic_json)
    end
  end
end
