module LtiAdvantage
  module Exceptions
    class LineItemError < StandardError
    end

    class ConfigurationError < StandardError
    end

    class NamesAndRolesError < StandardError
    end

    class ScoreError < StandardError
    end

    class NoLTIDeployment < StandardError
    end

  end
end
