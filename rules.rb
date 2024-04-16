class Rules
  attr_accessor :moves
  def initialize(moves)
    @moves = moves
  end
  
  def verdict(cmi, umi)
    return "Draw" if cmi==umi
    l = @moves.length
    hl = l/2
    return ((umi+hl<l) && (cmi>umi && cmi<=(umi+hl))) || ((umi+hl>=l) && (cmi>umi || cmi<=(umi+hl)%l)) ? "Win" : "Lose"
  end
end