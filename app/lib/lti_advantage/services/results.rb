module LtiAdvantage
  module Services
    # Canvas API docs: https://canvas.instructure.com/doc/api/result.html
    class Results < LtiAdvantage::Services::Base

      def list(line_item_id)
        url = "#{line_item_id}/results"
        HTTParty.get(url, headers: headers)
      end

      def show(line_item_id, result_id)
        url = "#{line_item_id}/results/#{result_id}"
        HTTParty.get(url, headers: headers)
      end

    end
  end
end
