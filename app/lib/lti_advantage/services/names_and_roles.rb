module LtiAdvantage
  module Services
    class NamesAndRoles < LtiAdvantage::Services::Base

      def endpoint
        url = @lti_token.dig(LtiAdvantage::Definitions::NAMES_AND_ROLES_CLAIM, "context_memberships_url")
        raise LtiAdvantage::Exceptions::NamesAndRolesError, "Unable to access names and roles" unless url.present?

        url
      end

      def valid?
        return false unless @lti_token.dig(LtiAdvantage::Definitions::NAMES_AND_ROLES_CLAIM)

        @lti_token.dig(LtiAdvantage::Definitions::NAMES_AND_ROLES_CLAIM, "service_versions") ==
          LtiAdvantage::Definitions::NAMES_AND_ROLES_SERVICE_VERSIONS
      end

      # List names and roles
      # limit query param - see 'Limit query parameter' section of NRPS spec
      # to get differences - see 'Membership differences' section of NRPS spec
      # query parameter of 'role=http%3A%2F%2Fpurl.imsglobal.org%2Fvocab%2Flis%2Fv2%2Fmembership%23Learner'
      # will filter the memberships to just those which have a Learner role.
      # query parameter of 'rlid=49566-rkk96' will filter the memberships to just those which
      # have access to the resource link with ID '49566-rkk96'
      def list(query = nil)
        url = endpoint
        url << "?#{query}" if query.present?
        HTTParty.get(
          url,
          headers: headers(
            {
              "Content-Type" => "application/vnd.ims.lti-nrps.v2.membershipcontainer+json",
            },
          ),
        )
      end
    end
  end
end
