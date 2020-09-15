class Types::BaseObject < GraphQL::Schema::Object
  field_class Fields::Guardable
end
