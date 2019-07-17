module LtiAdvantage
  module Services
    # Canvas API docs https://canvas.instructure.com/doc/api/line_items.html
    class LineItems < LtiAdvantage::Services::Base

      def endpoint
        url = @lti_token.dig(LtiAdvantage::Definitions::AGS_CLAIM, "lineitems")
        raise LtiAdvantage::Exceptions::LineItemError, "Unable to access line items" unless url.present?
        url
      end

      # Helper method to generate a default set of attributes
      def generate(
        label:,
        max_score:,
        start_date_time:,
        end_date_time:,
        resource_id: nil,
        tag: nil,
        resource_link_id: nil,
        external_tool_url: nil
      )
        attrs = {
          scoreMaximum: max_score,
          label: label,
          resourceId: resource_id,
          tag: tag,
          startDateTime: start_date_time,
          endDateTime: end_date_time,
        }
        attrs["resourceLinkId"] = resource_link_id if resource_link_id
        if external_tool_url
          attrs["https://canvas.instructure.com/lti/submission_type"] = {
            type: "external_tool",
            external_tool_url: external_tool_url,
          }
        end
        attrs
      end

      # List line items
      # Canvas: https://canvas.beta.instructure.com/doc/api/line_items.html#method.lti/ims/line_items.index
      def list
        HTTParty.get(endpoint, headers: headers)
      end

      # Get a specific line item
      # https://canvas.beta.instructure.com/doc/api/line_items.html#method.lti/ims/line_items.show
      def show(line_item_url)
        HTTParty.get(line_item_url, headers: headers)
      end

      # Create a line item
      # https://www.imsglobal.org/spec/lti-ags/v2p0/#creating-a-new-line-item
      # Canvas: https://canvas.beta.instructure.com/doc/api/line_items.html#method.lti/ims/line_items.create
      def create(attrs = nil)
        HTTParty.post(endpoint, body: attrs, headers: headers)
      end

      # Update a line item
      # Canvas: https://canvas.beta.instructure.com/doc/api/line_items.html#method.lti/ims/line_items.update
      def update(line_item_url, attrs)
        HTTParty.put(line_item_url, body: attrs, headers: headers)
      end

      def delete(line_item_url)
        HTTParty.delete(line_item_url, headers: headers)
      end

    end
  end
end
