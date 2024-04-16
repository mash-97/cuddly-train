require_relative './random-key.rb'
require_relative './hmac.rb'
require_relative './rules.rb'
require_relative './helper-table.rb'


class GeneralNonTransitiveOnePlay
  def initialize(moves)
    if not moves.length.odd? or (moves.length != moves.uniq.length) or moves.length==1 then
      raise ArgumentError.new("Odd numbers (>1) of unique moves required!\nExample:\n  ruby main.rb paper rock scissor")
    end
    @moves = moves
    @rules = Rules.new(@moves)
    @helper_table = HelperTable.new(@rules)
    @cmi = rand(0...@moves.length)
    @key = RandomKey.new()
    @hmac = HMAC.new(@key, @moves[@cmi])
  end

  def getUserMove()
    self.class.showAvailableMoves(@moves)
    print("Enter your move: ")
    return $stdin.gets.chomp()
  end

  def play
    puts("HMAC: #{@hmac}")
    while true do
      user_move = getUserMove()
      case user_move
      when "?"
        puts()
        puts(@helper_table.table)
        um = (0...@moves.length).to_a.sample(1).first
        cm = (0...@moves.length).to_a.reject{|x|x==um}.sample(1).first
        puts("Example:\n  [User(row), PC(column)] : Verdict\n  [#{@moves[um]}, #{@moves[cm]}] : #{@rules.verdict(cm, um)}")
        puts()
        next
      when /\d+/
        user_move = user_move.to_i
        case user_move
        when 0
          return nil
        when (1..@moves.length)
          puts("Your move: #{@moves[user_move-1]}")
          puts("Computer move: #{@moves[@cmi]}")
          case @rules.verdict(@cmi, user_move-1)
          when "Draw"
            puts("Draw!")
          when "Lose"
            puts("You lose!")
          when "Win"
            puts("You Win!")
          end
          puts("HMAC key: #{@key}")
          return nil
        end
      end
      puts("Please enter valid input!")
    end
  end

  def self.showAvailableMoves(moves)
    puts("Available moves:")
    moves.each_with_index{|m,i| puts("#{i+1} - #{m}")}
    puts("0 - exit")
    puts("? - help")
  end
end