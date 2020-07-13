class Types::SomeModelAttributes < Types::BaseInputObject
  argument :id, ID, required: false
  argument :name, String, required: true
end
