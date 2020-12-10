class Types::HelloWorldQueryType < Types::BaseObject
  field :welcome_message, String, null: true do
    description "Get the Hello World welcome message"
    argument :name, String, required: true
  end

  def welcome_message(name:)
    "Hello #{name}!"
  end
end
