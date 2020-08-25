module Mutations
  class BaseMutation < ::GraphQL::Schema::Mutation
    def lrn_auth
      context[:current_application_instance].learnosity_authentication
    end
  end
end
