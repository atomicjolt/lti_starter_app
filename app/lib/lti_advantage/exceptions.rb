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
  end
end
