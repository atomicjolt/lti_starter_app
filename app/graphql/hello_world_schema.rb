class HelloWorldSchema < GraphQL::Schema
  use GraphQL::Batch

  mutation(Types::HelloWorldMutationType)
  query(Types::HelloWorldQueryType)
end
