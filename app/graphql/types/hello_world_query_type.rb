class Types::HelloWorldQueryType < Types::BaseObject
  field :get_sample, Types::JournalActivityType, null: true do
    description "Find a SomeModel by ID"
    argument :id, ID, required: true
  end

  def get_journal_activity(id:)
    SomeModel.find(id)
  end
end
