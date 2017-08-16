# Derived from https://github.com/instructure/lti_originality_report_example
# MIT License

# Copyright (c) 2017 Instructure, Inc.
# Copyright (c) 2017 Atomic Jolt

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require "rails_helper"
require "lti_spec_helper"

RSpec.describe Lti2::RegistrationsController, type: :controller do
  include_context "lti_spec_helper"

  let(:request_parameters) do
    {
      "lti_message_type" => "ToolProxyRegistrationRequest",
      "lti_version" => "LTI-2p0",
      "reg_key" => "026e4140-14a3-43f2-a37e-f79a93d41075",
      "reg_password" => "6969103a-b205-42a7-aa07-0304cc60c653",
      "tc_profile_url" => "http://www.example.com/api/lti/courses/2/tool_consumer_profile",
      "launch_presentation_return_url" => "http://www.example.com/courses/2/lti/registration_return",
      "launch_presentation_document_target" => "iframe",
      "oauth2_access_token_url" => "http://www.example.com/api/lti/courses/2/authorize",
      "ext_tool_consumer_instance_guid" => "edea7cb339bf18da4132895e1a44e4b8ee7bd8d9.example.com",
      "ext_api_domain" => "example.com",
    }
  end

  before do
    @application_instance = FactoryGirl.create(:application_instance)
    allow(controller).to receive(:current_application_instance).and_return(@application_instance)
    controller.request.request_parameters = request_parameters
  end

  describe "POST #create" do
    it "registers a tool proxy" do
      post :create, params: registration_message
      expect(response.status).to eq 302
      expect(response).to redirect_to "http://www.example.com/courses/2/lti/registration_return?status=success&tool_proxy_guid=#{ToolProxy.last.guid}"
    end

    it "persists a ToolProxy" do
      prev_count = ToolProxy.count
      post :create, params: registration_message
      expect(ToolProxy.count).to eq prev_count + 1
    end

    it "saves the authorization url" do
      post :create, params: registration_message
      expect(ToolProxy.last.authorization_url).to eq "http://www.example.com/api/lti/courses/2/authorize"
    end

    it "assembles both halves of the shared secret" do
      post :create, params: registration_message
      tp = ToolProxy.last
      expect(tp.shared_secret).to include tc_half_shared_secret
    end

    it "redirects with status set to failure if required capabilities are missing" do
      prev_capabilities = ToolProxy::REQUIRED_CAPABILITIES
      ToolProxy::REQUIRED_CAPABILITIES = %w(Capaability.not.Offered).freeze
      post :create, params: registration_message
      expect(response).to redirect_to "http://www.example.com/courses/2/lti/registration_return?status=failure&lti_errormsg=Missing%20required%20capabilities"
      ToolProxy::REQUIRED_CAPABILITIES = prev_capabilities
    end

    it "redirects with status set to failure if status of tp create response is not success" do
      allow(controller).to receive(:create_tool_proxy) { false }
      post :create, params: registration_message
      expect(response).to redirect_to "http://www.example.com/courses/2/lti/registration_return?status=failure&lti_errormsg=Error%20received%20from%20tool%20consumer"
    end
  end
end
