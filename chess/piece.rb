class Piece
  attr_reader :color, :symbol

  def initialize(color = nil, symbol = nil)
    @color = color
    @symbol = symbol
  end
end

class Rook < Piece
  def initialize(color)
    super(color, :R)
  end
end

class Knight < Piece
  def initialize(color)
    super(color, :N)
  end
end

class Bishop < Piece
  def initialize(color)
    super(color, :B)
  end
end

class Queen < Piece
  def initialize(color)
    super(color, :Q)
  end
end

class King < Piece
  def initialize(color)
    super(color, :K)
  end
end

class Pawn < Piece
  def initialize(color)
    super(color, :p)
  end
end
