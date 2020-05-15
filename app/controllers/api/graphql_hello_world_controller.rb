class Api::GraphqlHelloWorldController < Api::GraphqlController
  def schema
    HelloWorldSchema
  end
end
