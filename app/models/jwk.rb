class Jwk < ApplicationRecord
  belongs_to :application
  before_create :generate_keys

  def generate_keys
    pkey = OpenSSL::PKey::RSA.generate(2048)
    self.pem = pkey.to_pem
    self.kid = pkey.to_jwk.thumbprint
  end

  def alg
    "RS256"
  end

  def private_key
    OpenSSL::PKey::RSA.new(pem)
  end

  def to_json
    pkey = OpenSSL::PKey::RSA.new(pem)
    json = JSON::JWK.new(pkey.public_key, kid: kid).as_json
    json["use"] = "sig"
    json["alg"] = alg
    json
  end
end
