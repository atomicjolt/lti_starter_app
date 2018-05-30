module Lti
  class Request
    def self.oauth_consumer_key(request)
      key = request.env["oauth_consumer_key"] ||
        request.params["oauth_consumer_key"] ||
        request.session[:oauth_consumer_key]

      if key.blank?
        if bearer_token = request.get_header("HTTP_AUTHORIZATION")
          token = bearer_token.split(" ").last
          decoded_token = AuthToken.decode(token, nil, false)
          # Canvas sticks the `kid` in the header
          # We stick the `kid` in the payload
          key = decoded_token[PAYLOAD]["kid"] || decoded_token[HEADER]["kid"]
        end
      end
      key
    end
  end
end
