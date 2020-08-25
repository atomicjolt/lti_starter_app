class Types::BaseObject < GraphQL::Schema::Object
  field_class Fields::Guardable

  def lrn_auth
    context[:current_application_instance].learnosity_authentication
  end
end
