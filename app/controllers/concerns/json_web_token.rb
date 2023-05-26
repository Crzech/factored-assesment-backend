module JsonWebToken
  extend ActiveSupport::Concern

  def jwt_enconde(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, hmac_secret)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, hmac_secret)[0]
    HashWithIndifferentAccess.new decoded
  end

  def hmac_secret
    ENV["API_SECRET_KEY"]
  end
end
