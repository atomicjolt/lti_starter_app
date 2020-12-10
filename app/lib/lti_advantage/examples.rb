module LtiAdvantage
  class Examples

    def initialize(lti_token, application_instance)
      @lti_token = lti_token
      @application_instance = application_instance
    end

    # Run a series of lti advantage examples
    def run
      if LtiAdvantage::Definitions.deep_link_launch?(@lti_token)
        # Handle deep link request
        @is_deep_link = true
      else
        # Examples demonstrating LTI Advantage services
        names_and_roles_example
        if line_item = line_item_example
          scores_example(line_item, @names_and_roles)
          results_example(line_item)
        end
      end
    end

    # This method will add LTI Advantage related values to the settings object
    # that is used to send data to the client
    def add_to_settings(settings)
      # Example of LTI Advantage name and role service:
      if @names_and_roles
        settings[:names_and_roles] = @names_and_roles
      end

      # Example of LTI Advantage line item service:
      if @line_items
        settings[:line_items] = @line_items
      end

      # Example of LTI Advantage name and score service:
      if @line_item_results
        settings[:line_item_results] = @line_item_results
      end

      if @is_deep_link
        settings[:deep_link_settings] = @lti_token[LtiAdvantage::Definitions::DEEP_LINKING_CLAIM]
      end

      settings
    end

    # This method demonstrates create, delete and update of line items using
    # LtiAdvantage::Services::LineItems
    def line_item_example
      line_item_service = LtiAdvantage::Services::LineItems.new(@application_instance, @lti_token)
      line_items = line_item_service.list

      @line_items = JSON.parse(line_items.body)

      resource_id = 1
      tag = "lti-advantage"
      external_tool_url = "https://#{@application_instance.domain}/lti_launches"

      delete_items = false

      if ["200", "201"].include?(line_items.response.code)
        if delete_items
          # Delete Line items
          @line_items.each do |li|
            line_item_service.delete(li["id"])
          end
          found = false
        else
          found = @line_items.detect { |li| li["tag"] == tag }
        end

        result = if found
                   line_item_attrs = {
                     label: "LTI Advantage test item #{Time.now.utc}",
                     scoreMaximum: 10,
                     resourceId: resource_id,
                     tag: tag,
                   }
                   line_item_service.update(found["id"], line_item_attrs)
                 else
                   line_item_attrs = line_item_service.generate(
                     label: "LTI Advantage test item #{Time.now.utc}",
                     max_score: 10,
                     resource_id: resource_id,
                     tag: tag,
                     start_date_time: Time.now.utc - 1.day,
                     end_date_time: Time.now.utc + 45.days,
                     external_tool_url: external_tool_url,
                   )
                   line_item_service.create(line_item_attrs)
                end
        item = JSON.parse(result.body)

        # Get a single item
        line_item_service.show(item["id"])

        item
      else
        # There was an error and the line items API isn't available.
        # For example the course might be closed. These errors will be
        # rendered on the client
      end
    end

    # This example demonstrates writing scores back to the platform using the
    # LtiAdvantage::Services::Score class
    def scores_example(line_item, names_and_roles)
      return unless names_and_roles.present?

      score_service = LtiAdvantage::Services::Score.new(@application_instance, @lti_token)
      score_service.id = line_item["id"]
      names_and_roles["members"].map do |name_role|
        in_role = !(name_role["roles"] &
          [LtiAdvantage::Definitions::STUDENT_SCOPE, LtiAdvantage::Definitions::LEARNER_SCOPE]).empty?

        if in_role && name_role["status"] == "Active"
          score = score_service.generate(
            user_id: name_role["user_id"],
            score: 10,
            max_score: line_item["scoreMaximum"],
            comment: "Great job",
            activity_progress: "Completed",
            grading_progress: "FullyGraded",
          )
          result = score_service.send(score)
          JSON.parse(result.body)
        end
      end
    end

    # This example demonstrates reading scores from the platform using the
    # LtiAdvantage::Services::Results class
    def results_example(line_item)
      results_service = LtiAdvantage::Services::Results.new(@application_instance, @lti_token)
      result = results_service.list(line_item["id"])
      @line_item_results = JSON.parse(result)
    end

    # This example demonstrates reading names and roles from the platform using the
    # LtiAdvantage::Services::NamesAndRoles class
    def names_and_roles_example
      names_and_roles_service = LtiAdvantage::Services::NamesAndRoles.new(@application_instance, @lti_token)
      @names_and_roles = JSON.parse(names_and_roles_service.list.body) if names_and_roles_service.valid?
    end
  end
end
