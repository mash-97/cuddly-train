require 'securerandom'

class RandomKey
  attr_accessor :key
  def initialize()
    @key = SecureRandom.hex(32)
  end
  def to_s
    @key
  end
end