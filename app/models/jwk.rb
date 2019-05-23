class Jwk < ApplicationRecord
  before_create :generate_keys

  def generate_keys
    pkey = OpenSSL::PKey::RSA.generate(2048)
    self.pem = pkey.to_pem
    self.kid = pkey.to_jwk.thumbprint
  end

  def to_json
    pkey = OpenSSL::PKey::RSA.new(pem)
    json = JSON::JWK.new(pkey.public_key, kid: kid).as_json
    json["use"] = "sig"
    json["alg"] = "RS256"
    json
  end
end
