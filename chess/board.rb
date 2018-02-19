require_relative 'piece'
require_relative 'null_piece'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {NullPiece.new}}
    
    self[[0,0]] = self[[0,7]] = Rook.new(:white)
    self[[7,0]] = self[[7,7]] = Rook.new(:black)

    self[[0,1]] = self[[0,6]] = Knight.new(:white)
    self[[7,1]] = self[[7,6]] = Knight.new(:black)

    self[[0,2]] = self[[0,5]] = Bishop.new(:white)
    self[[7,2]] = self[[7,5]] = Bishop.new(:black)

    self[[0,3]] = Queen.new(:white)
    self[[7,3]] = Queen.new(:black)

    self[[0,4]] = King.new(:white)
    self[[7,4]] = King.new(:black)

    8.times do |idx|
      self[[1,idx]] = Pawn.new(:white)
      self[[6,idx]] = Pawn.new(:black)
    end
  end

  def [](pos)
    row, col = pos
    self.grid[row][col]
  end

  def []= (pos, value)
    row, col = pos
    self.grid[row][col] = value
  end

  def move_piece(start_pos, end_pos)
    begin
      piece = self[start_pos]
      raise NoPieceError.new if piece.is_a?(NullPiece)
      raise BlockedError.new unless self[end_pos].is_a?(NullPiece)

      self[start_pos] = NullPiece.new
      self[end_pos] = piece
    rescue NoPieceError => e
      puts e.message
    rescue BlockedError => e
      puts e.message
    end
  end
end

class NoPieceError < ArgumentError
  def message
    "There is no piece at given position."
  end
end

class BlockedError < ArgumentError
  def message
    "The end position is unavailable."
  end
end
