require 'byebug'

require_relative 'piece'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance } }
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

      self[start_pos] = NullPiece.instance
      add_piece(piece, end_pos)
    rescue NoPieceError => e
      puts e.message
    rescue BlockedError => e
      puts e.message
    end
  end

  def move_piece!(start_pos, end_pos)

  end

  def add_piece(piece, pos)
    self[pos] = piece
    piece.update_pos(pos, self)
  end

  def self.new_game
    board = Board.new

    board.add_piece(Rook.new(:white), [0,0])
    board.add_piece(Rook.new(:white), [0,7])
    board.add_piece(Rook.new(:black), [7,0])
    board.add_piece(Rook.new(:black), [7,7])

    board.add_piece(Knight.new(:white), [0,1])
    board.add_piece(Knight.new(:white), [0,6])
    board.add_piece(Knight.new(:black), [7,1])
    board.add_piece(Knight.new(:black), [7,6])

    board.add_piece(Bishop.new(:white), [0,2])
    board.add_piece(Bishop.new(:white), [0,5])
    board.add_piece(Bishop.new(:black), [7,2])
    board.add_piece(Bishop.new(:black), [7,5])

    board.add_piece(Queen.new(:white), [0,3])
    board.add_piece(Queen.new(:black), [7,3])

    board.add_piece(King.new(:white), [0,4])
    board.add_piece(King.new(:black), [7,4])

    8.times do |idx|
      board.add_piece(Pawn.new(:white), [1,idx])
      board.add_piece(Pawn.new(:black), [6,idx])
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
