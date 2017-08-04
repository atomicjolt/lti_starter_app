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

module RegistrationHelper
  # tool_consumer_profile
  #
  # Returns the tool consumer profile
  def tool_consumer_profile
    @_tool_consumer_profile ||= tool_proxy_registration_service.tool_consumer_profile
  end

  # registration_request
  #
  # Returns a model representing the incoming registration
  # request
  def registration_request
    @_registration_request ||= begin
      reg_request = IMS::LTI::Models::Messages::RegistrationRequest.new(request.request_parameters)
      reg_request.launch_url = request.url
      reg_request
    end
  end

  # tool_proxy_registration_service
  #
  # Returns the registration service to aid in
  # registering a tool proxy with Canvas
  def tool_proxy_registration_service
    @_tool_proxy_registration_service ||= begin
      IMS::LTI::Services::ToolProxyRegistrationService.new(registration_request)
    end
  end

  # create_tool_proxy
  #
  # Attempts to create the tool proxy in Canvas.
  # If successful the tool consumer's half of the shared
  # secret is prepended to the tool provider's half and
  # saved.
  #
  # The tool proxy guid is also retrieved from the response
  # and saved.
  def create_tool_proxy(tool_proxy)
    tp_response = tool_proxy_registration_service.register_tool_proxy(tool_proxy.to_ims_tool_proxy)
    if tp_response
      shared_secret = tp_response.tc_half_shared_secret + tool_proxy.tp_half_shared_secret
      return tool_proxy.update_attributes(guid: tp_response.tool_proxy_guid, shared_secret: shared_secret)
    end
    false
  end

  # authorization_service
  #
  # Returns the service used to retrieve access
  # tokens from Canvas
  def authorization_service
    find_service("#vnd.Canvas.authorization")
  end

  # find_service
  #
  # searches the tool consumer profile's
  # "service_offered" for a service with an id
  # that ends in the specified string
  def find_service(service_id)
    tool_consumer_profile.services_offered.detect { |s| s.id.end_with? service_id }
  end

  # registration_success_url
  #
  # returns the url to redirect to if registering
  # the tool proxy is successful
  def registration_success_url(tp_guid)
    "#{registration_request.launch_presentation_return_url}?status=success&tool_proxy_guid=#{tp_guid}"
  end

  # registration_failure_url
  #
  # returns the url to redirect to if registering the
  # tool proxy fails
  def registration_failure_url(message)
    "#{registration_request.launch_presentation_return_url}?status=failure&lti_errormsg=#{URI.encode(message)}"
  end
end
