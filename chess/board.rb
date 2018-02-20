require 'byebug'

require_relative 'piece'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.new } }
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

  def move_piece!(start_pos, end_pos)
    
  end

  def self.new_game
    board = Board.new

    board[[0,0]] = Rook.new(:white)
    board[[0,7]] = Rook.new(:white)
    board[[7,0]] = Rook.new(:black)
    board[[7,7]] = Rook.new(:black)

    board[[0,1]] = Knight.new(:white)
    board[[0,6]] = Knight.new(:white)
    board[[7,1]] = Knight.new(:black)
    board[[7,6]] = Knight.new(:black)

    board[[0,2]] = Bishop.new(:white)
    board[[0,5]] = Bishop.new(:white)
    board[[7,2]] = Bishop.new(:black)
    board[[7,5]] = Bishop.new(:black)

    board[[0,3]] = Queen.new(:white)
    board[[7,3]] = Queen.new(:black)

    board[[0,4]] = King.new(:white)
    board[[7,4]] = King.new(:black)

    8.times do |idx|
      board[[1,idx]] = Pawn.new(:white)
      board[[6,idx]] = Pawn.new(:black)
    end

    board
  end

  def valid_pos?(pos)
    pos.all? { |num| num.between?(0, 7) }
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
