require 'openssl'
require_relative './random-key.rb'
class HMAC
  attr_accessor :hmac
  def initialize(random_key, move)
    @hmac = OpenSSL::HMAC.hexdigest('SHA3-256', random_key.to_s, move)
  end
  def to_s
    @hmac
  end
end
