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

RSpec.describe RegistrationHelper, type: :helper do
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
  let(:url) { "http://www.url.com" }
  let(:domain) { "test.host" }
  let(:request) { double(url: url, request_parameters: request_parameters, domain: domain) }

  describe "#registration_request" do
    it "sets the launch url to the request url" do
      expect(helper.registration_request.launch_url).to eq "http://test.host"
    end
  end

  describe "#tool_proxy_registration_service" do
    it "returns the tool proxy registration service" do
      expect(helper.tool_proxy_registration_service.is_a?(IMS::LTI::Services::ToolProxyRegistrationService)).to be true
    end
  end

  describe "#registration_success_url" do
    it "sets the status param to success" do
      url = URI.parse(helper.registration_success_url("tp-guid"))
      expect(url.query).to include "status=success"
    end

    it "sets the tool proxy guid param" do
      url = URI.parse(helper.registration_success_url("tp-guid"))
      expect(url.query).to include "tool_proxy_guid=tp-guid"
    end
  end

  describe "#registration_failure_url" do
    it "sets the status to failure" do
      url = URI.parse(helper.registration_failure_url("this is a message"))
      expect(url.query).to include "status=failure"
    end

    it "sets the lti_errormsg" do
      url = URI.parse(helper.registration_failure_url("this is a message"))
      expect(url.query).to include "lti_errormsg=#{URI.encode('this is a message')}"
    end
  end
end
