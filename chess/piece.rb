require_relative 'modules'

class Piece
  attr_reader :color, :symbol

  def initialize(color = nil, symbol = nil)
    @color = color
    @symbol = symbol
    @current_pos = []
    @board = nil
  end

  def update_pos(pos, board)
    @current_pos = pos
    @board = board
  end

end

class Rook < Piece
  include SlidingPiece

  def initialize(color)
    if color == :white
      super(color, "\u2656")
    else
      super(color, "\u265C")
    end
  end
end

class Knight < Piece
  include SteppingPiece

  def initialize(color)
    if color == :white
      super(color, "\u2658")
    else
      super(color, "\u265E")
    end
  end
end

class Bishop < Piece
  include SlidingPiece

  def initialize(color)
    if color == :white
      super(color, "\u2657")
    else
      super(color, "\u265D")
    end
  end
end

class Queen < Piece
  include SlidingPiece

  def initialize(color)
    if color == :white
      super(color, "\u2655")
    else
      super(color, "\u265B")
    end
  end
end

class King < Piece
  include SteppingPiece

  def initialize(color)
    if color == :white
      super(color, "\u2654")
    else
      super(color, "\u265A")
    end
  end
end

class Pawn < Piece
  def initialize(color)
    if color == :white
      super(color, "\u2659")
    else
      super(color, "\u265F")
    end
  end
end

class NullPiece < Piece
  def initialize
    super(:default, " ")
  end
end
