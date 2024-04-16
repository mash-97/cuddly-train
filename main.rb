
require 'bundler/setup'
require_relative './gentopg.rb'

if $0==__FILE__ then
  begin
    game = GeneralNonTransitiveOnePlay.new(ARGV)
    game.play()
  rescue Exception => e
    puts(e)
  end
end
