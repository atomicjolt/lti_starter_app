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
      "kty" => "RSA",
      "e" => "AQAB",
      "n" => "0VjK0uLhrT_-jFpih7mL2e78y_fd5ulEOJUU8eCFcEPdArKSlbyqf1kuBy29iuXcK3IxYWLQ6Wra3PuUKie7qW2_XvcOxG9vpe4jQtTGxQ8x2CwRfS4WYp3ii7WzTugMvG0UXxJlgFeHxDjABzBYRDkkT9GLpa2oMXAnIlyEUE12tAc-J3-plqPE-28hhlWpBPNQ0sgWfHme82qhrOQRNMJWIYqlHaoGk4WefIC8FHL39CkIMjbgwUSRX2oNXij4WW-9hGBW2e2qPXAfO8QSrwYdJCApJv7-VBHGsLGdNhvGBfFsI-Satt4L6WLNphfdL5LzN7c3Xr7WbCu2aRrkJw",
      "kid" => "_iss3-5vv94LDsvE_zQY3gtSOQNhA6z1HdwxGZvhZ3c",
      "use" => "sig",
      "alg" => "RS256",
    }
  end

  describe "lti_to_lti_advantage" do
    it "converts basic lti configuration into lti advantage" do
      config = described_class.lti_to_lti_advantage(@jwk, @domain, @basic_config)
      expect(config).to be_present
      expect(config).to eq(
        {
          title: "Atomic LTI test",
          scopes: [
            "https://purl.imsglobal.org/spec/lti-ags/scope/lineitem",
            "https://purl.imsglobal.org/spec/lti-ags/scope/result.readonly",
            "https://purl.imsglobal.org/spec/lti-ags/scope/score",
            "https://purl.imsglobal.org/spec/lti-nrps/scope/contextmembership.readonly",
          ],
          icon: "https://www.example.com/oauth_icon.png",
          target_link_uri: "https://www.example.com/lti_launches",
          oidc_initiation_url: "https://www.example.com/lti_launches/init",
          public_jwk: "{\"kty\":\"RSA\",\"e\":\"AQAB\",\"n\":\"0VjK0uLhrT_-jFpih7mL2e78y_fd5ulEOJUU8eCFcEPdArKSlbyqf1kuBy29iuXcK3IxYWLQ6Wra3PuUKie7qW2_XvcOxG9vpe4jQtTGxQ8x2CwRfS4WYp3ii7WzTugMvG0UXxJlgFeHxDjABzBYRDkkT9GLpa2oMXAnIlyEUE12tAc-J3-plqPE-28hhlWpBPNQ0sgWfHme82qhrOQRNMJWIYqlHaoGk4WefIC8FHL39CkIMjbgwUSRX2oNXij4WW-9hGBW2e2qPXAfO8QSrwYdJCApJv7-VBHGsLGdNhvGBfFsI-Satt4L6WLNphfdL5LzN7c3Xr7WbCu2aRrkJw\",\"kid\":\"_iss3-5vv94LDsvE_zQY3gtSOQNhA6z1HdwxGZvhZ3c\",\"use\":\"sig\",\"alg\":\"RS256\"}",
          description: "This is the test application for the Atomic LTI engine",
          custom_fields: { "custom_canvas_api_domain" => "$Canvas.api.domain" },
          extensions: [
            {
              domain: "https://www.example.com",
              platform: "canvas.instructure.com",
              settings: {
                icon_url: "https://www.example.com/atomicjolt.png",
                placements: [],
                privacy_level: "public",
                selection_height: 500,
                selection_width: 500,
                text: "Atomic LTI test",
              },
              tool_id: "hellolti",
            },
          ],
        },
      )
    end

    it "converts extended configuration xml for an LTI tool with a assignment selection into lti advantage" do
      assignment_selection = {
        canvas_icon_class: "icon-lti",
        message_type: "ContentItemSelectionRequest",
        url: @launch_url,
        selection_width: 50,
        selection_height: 50,
      }
      args = @basic_config.merge({ assignment_selection: assignment_selection })
      config = described_class.lti_to_lti_advantage(@jwk, @domain, args)
      expect(config).to be_present
      expect(config).to eq(
        {
          title: "Atomic LTI test",
          scopes: [
            "https://purl.imsglobal.org/spec/lti-ags/scope/lineitem",
            "https://purl.imsglobal.org/spec/lti-ags/scope/result.readonly",
            "https://purl.imsglobal.org/spec/lti-ags/scope/score",
            "https://purl.imsglobal.org/spec/lti-nrps/scope/contextmembership.readonly",
          ],
          icon: "https://www.example.com/oauth_icon.png",
          target_link_uri: "https://www.example.com/lti_launches",
          oidc_initiation_url: "https://www.example.com/lti_launches/init",
          public_jwk: "{\"kty\":\"RSA\",\"e\":\"AQAB\",\"n\":\"0VjK0uLhrT_-jFpih7mL2e78y_fd5ulEOJUU8eCFcEPdArKSlbyqf1kuBy29iuXcK3IxYWLQ6Wra3PuUKie7qW2_XvcOxG9vpe4jQtTGxQ8x2CwRfS4WYp3ii7WzTugMvG0UXxJlgFeHxDjABzBYRDkkT9GLpa2oMXAnIlyEUE12tAc-J3-plqPE-28hhlWpBPNQ0sgWfHme82qhrOQRNMJWIYqlHaoGk4WefIC8FHL39CkIMjbgwUSRX2oNXij4WW-9hGBW2e2qPXAfO8QSrwYdJCApJv7-VBHGsLGdNhvGBfFsI-Satt4L6WLNphfdL5LzN7c3Xr7WbCu2aRrkJw\",\"kid\":\"_iss3-5vv94LDsvE_zQY3gtSOQNhA6z1HdwxGZvhZ3c\",\"use\":\"sig\",\"alg\":\"RS256\"}",
          description: "This is the test application for the Atomic LTI engine",
          custom_fields: { "custom_canvas_api_domain" => "$Canvas.api.domain" },
          extensions: [
            {
              domain: "https://www.example.com",
              platform: "canvas.instructure.com",
              settings: {
                icon_url: "https://www.example.com/atomicjolt.png",
                placements: [
                  {
                    "canvas_icon_class" => "icon-lti",
                    "message_type" => "ContentItemSelectionRequest",
                    "placement" => :assignment_selection,
                    "selection_height" => 50,
                    "selection_width" => 50,
                    "url" => "https://www.example.com/lti_launches",
                  },
                ],
                privacy_level: "public",
                selection_height: 500,
                selection_width: 500,
                text: "Atomic LTI test",
              },
              tool_id: "hellolti",
            },
          ],
        },
      )
    end
  end
end
