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

# RegistrationController
#
# Handles incoming registration requests from tool
# consumers. For a more explicit example of LTI 2
# registration please see
# https://github.com/instructure/lti2_reference_tool_provider
class Lti2::RegistrationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  include RegistrationHelper

  # register
  #
  # handles incoming registration requests from the
  # tool consumer, fetches a custom tool consumer profile
  # from Canvas, and registers a tool proxy
  def create
    if ToolProxy::REQUIRED_CAPABILITIES.present?
      tcps = tool_consumer_profile_service
      # logger.debug(tcps.tcp.as_json)
      unless tcps.supports_capabilities?(*ToolProxy::REQUIRED_CAPABILITIES)
        redirect_to registration_failure_url("Missing required capabilities")
        return
      end
    end

    tool_proxy = current_application_instance.tool_proxies.new(
      tcp_url: registration_request.tc_profile_url,
      base_url: request.base_url,
      authorization_url: authorization_service.endpoint,
    )

    if create_tool_proxy(tool_proxy)
      redirect_to registration_success_url(tool_proxy.guid)
    else
      redirect_to registration_failure_url("Error received from tool consumer")
    end
  end
end
