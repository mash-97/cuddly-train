require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/test'
require 'minitest/spec'
require_relative './gentopg.rb'


def getInstanceVariables(obj, ivars=[])
  return ivars.collect{|iv| obj.instance_variable_get ('@'+iv.to_s).to_sym}
end


class TestGame < Minitest::Test
  def setup
    @gentopg = GeneralNonTransitiveOnePlay.new ['rock', 'paper', 'scissor', 'lizzard', 'spock']
    @moves, @rules, @hmac, @key = getInstanceVariables(@gentopg, [:moves, :rules, :hmac, :key])
  end

  def test_rules
    {
      ['rock', 'scissor'] => :win,
      ['scissor', 'rock'] => :lose,
      ['rock', 'lizzard'] => :lose,
      ['spock', 'paper'] => :win,
      ['paper', 'spock'] => :lose,
    }.each {
      |k,v|
      assert_equal @rules.verdict(@moves.index(k.last), @moves.index(k.first)), v 
    }
  end
end


describe GeneralNonTransitiveOnePlay do
  before do 
    @gentopg = GeneralNonTransitiveOnePlay.new ['rock', 'paper', 'scissor', 'lizzard', 'spock']
    @moves, @rules, @hmac, @key = getInstanceVariables(@gentopg, [:moves, :rules, :hmac, :key])
  end

  describe 'when asked about rules verdict' do
    it 'must respond positively' do
      {
        ['rock', 'scissor'] => :win,
        ['scissor', 'rock'] => :lose,
        ['rock', 'lizzard'] => :lose,
        ['spock', 'paper'] => :win,
        ['paper', 'spock'] => :lose,
      }.each {
        |k,v|
        _(@rules.verdict(@moves.index(k.last), @moves.index(k.first))).must_equal v 
      }
    end
  end
end
