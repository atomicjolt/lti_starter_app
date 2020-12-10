require "rails_helper"

RSpec.describe LtiAdvantage::Services::NamesAndRoles do
  before do
    setup_application_instance
    setup_canvas_lti_advantage(application_instance: @application_instance)
    @lti_token = LtiAdvantage::Authorization.validate_token(@application_instance, @params["id_token"])
  end

  describe "valid?" do
    it "indicates if the launch contains the names and roles scope" do
      names_and_roles_service = LtiAdvantage::Services::NamesAndRoles.new(@application_instance, @lti_token)
      expect(names_and_roles_service.valid?).to eq true
    end
  end

  describe "list" do
    it "lists users in the course and their roles" do
      names_and_roles_service = LtiAdvantage::Services::NamesAndRoles.new(@application_instance, @lti_token)
      names_and_roles = JSON.parse(names_and_roles_service.list.body)
      expect(names_and_roles["members"]).to be_present
    end

    it "adds a valid query string when a query argument is given" do
      allow(HTTParty).to receive(:get)
      names_and_roles_service = LtiAdvantage::Services::NamesAndRoles.new(@application_instance, @lti_token)
      query = { role: "http://purl.imsglobal.org/vocab/lis/v2/membership#Learner" }.to_query

      names_and_roles_service.list(query)

      expect(HTTParty).to have_received(:get).with(
        "#{@lti_token.dig(LtiAdvantage::Definitions::NAMES_AND_ROLES_CLAIM, 'context_memberships_url')}?#{query}",
        anything,
      )
    end

    context "when it looks like the LTI key is set to private" do
      before do
        allow(HTTParty).to receive(:get).and_return(
          OpenStruct.new(
            {
              body: {
                "members": [
                  { "status" => "Active", "user_id" => "1", "roles" => ["learner"] },
                  { "status" => "Active", "user_id" => "2", "roles" => ["learner"] },
                ],
              }.to_json,
            },
          ),
        )
      end

      it "raises an exception with a helpful error message" do
        names_and_roles_service = LtiAdvantage::Services::NamesAndRoles.new(@application_instance, @lti_token)

        expect do
          names_and_roles_service.list
        end.to raise_exception(
          LtiAdvantage::Exceptions::NamesAndRolesError,
          "Unable to fetch user data. Your LTI key may be set to private.",
        )
      end
    end
  end
end
