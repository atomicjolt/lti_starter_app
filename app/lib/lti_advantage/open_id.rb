module LtiAdvantage
  class OpenId
    def self.validate_open_id_state(state)
      state = AuthToken.decode(state)[0]
      if open_id_state = OpenIdState.find_by(nonce: state["nonce"])
        open_id_state.destroy
        true
      else
        false
      end
    end

    def self.state
      nonce = SecureRandom.hex(64)
      OpenIdState.create!(nonce: nonce)
      AuthToken.issue_token({ nonce: nonce })
    end
  end
end
