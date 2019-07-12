module LtiAdvantage
  module Services
    class LineItems < LtiAdvantage::Services::Base

      def valid?
      end

      def endpoint
        url = @lti_token.dig(LtiAdvantage::Definitions::AGS_CLAIM, "lineitems")
        raise LtiAdvantage::Exceptions:LineItemError, "Unable to access line items" unless url.present?
        url
      end

      # Generate a default set of attributes
      def generate(label:, max_score:, resource_id: nil, tag: nil, resource_link_id: nil)
        {
          scoreMaximum: max_score,
          label: label,
          resourceId: resource_id,
          tag: tag,
          # resourceLinkId: resource_link_id,
          # "startDateTime": "2018-03-06T20:05:02Z",
          # "endDateTime": "2018-04-06T22:05:03Z",
          # "https://canvas.instructure.com/lti/submission_type": {
          #   "type": "external_tool",
          #   "external_tool_url": "https://my.launch.url"
          # }
        }
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

      def update(line_item_url, attrs)
        HTTParty.put(line_item_url, headers: headers)
      end

      def delete(line_item_url)
        HTTParty.delete(line_item_url, headers: headers)
      end

    end
  end
end