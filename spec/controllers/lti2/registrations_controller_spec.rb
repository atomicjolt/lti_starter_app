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

  let(:tc_half_shared_secret) { SecureRandom.uuid }
  let(:tool_proxy_guid) { SecureRandom.uuid }
  let(:ims_tool_proxy) { double(tc_half_shared_secret: tc_half_shared_secret, tool_proxy_guid: tool_proxy_guid) }
  let(:ims_tool_consumer_profile) { IMS::LTI::Models::ToolConsumerProfile.from_json(tool_consumer_profile) }
  let(:tool_proxy_registration_service) { double(tool_consumer_profile: ims_tool_consumer_profile) }
  let(:registration_services_instance) { double(tp_registration_service: tool_proxy_registration_service) }
  let(:authentication_service) { double(additional_params: {}) }

  before do
    @application_instance = FactoryGirl.create(:application_instance)
    allow(controller).to receive(:current_application_instance).and_return(@application_instance)
    allow(registration_services_instance).to receive(:authentication_service=)
    allow(tool_proxy_registration_service).to receive(:register_tool_proxy) { ims_tool_proxy }
    allow(registration_services_instance).to receive(:authentication_service) { authentication_service }
    allow(registration_services_instance).to receive(:registration_service) { tool_proxy_registration_service }
  end

  describe "POST #create" do
    it "registers a tool proxy" do
      post :create, params: registration_message
      expect(response).to redirect_to "http://example.com/courses/2/lti/registration_return?status=success&tool_proxy_guid=#{tool_proxy_guid}"
    end

    it "persists a ToolProxy" do
      prev_count = ToolProxy.count
      post :create, params: registration_message
      expect(ToolProxy.count).to eq prev_count + 1
    end

    it "saves the authorization url" do
      post :create, params: registration_message
      expect(ToolProxy.last.authorization_url).to eq "http://example.com/api/lti/courses/2/authorize"
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
      expect(response).to redirect_to "http://example.com/courses/2/lti/registration_return?status=failure&lti_errormsg=Missing%20required%20capabilities"
      ToolProxy::REQUIRED_CAPABILITIES = prev_capabilities
    end

    it "redirects with status set to failure if status of tp create response is not success" do
      allow(tool_proxy_registration_service).to receive(:register_tool_proxy) { false }
      post :create, params: registration_message
      expect(response).to redirect_to "http://example.com/courses/2/lti/registration_return?status=failure&lti_errormsg=Error%20received%20from%20tool%20consumer"
    end
  end
end
