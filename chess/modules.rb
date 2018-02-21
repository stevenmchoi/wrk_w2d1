module SlidingPiece
  def moves(pos)
    if self.is_a?(Rook)
      horizontal(pos) + vertical(pos)
    elsif self.is_a?(Bishop)
      diagonal(pos)
    else
      horizontal(pos) + vertical(pos) + diagonal(pos)
    end
  end

  private
  def horizontal(pos)
    possible = []
    #right
    possible += loop_pos(pos,[0,1])

    #left
    possible += loop_pos(pos,[0,-1])

    possible
  end

  def vertical(pos)
    possible = []
    #up
    possible += loop_pos(pos,[1,0])

    #down
    possible += loop_pos(pos,[-1,0])

    possible
  end


  def diagonal(pos)
    possible = []
    #up-right
    possible += loop_pos(pos, [1,1])

    #down-left
    possible += loop_pos(pos,[-1,-1])

    #down-right
    possible += loop_pos(pos,[-1,1])

    #up-left
    possible += loop_pos(pos,[1,-1])

    possible
  end

  def loop_pos(pos, key)
    possible = []
    loop do
      pos = [pos, key].transpose.map { |arr| arr.reduce(:+) }
      break unless @board.valid_pos?(pos)
      if @board[pos].is_a?(Piece)
        other_piece = @board[pos]
        possible << pos unless other_piece.color == self.color
        break
      else
        possible << pos
      end
    end

    possible - [pos]
  end
end


module SteppingPiece
  def moves(pos)
    possible = []

    if self.is_a?(King)
      (-1..1).to_a.each do | row |
        (-1..1).to_a.each do | col |
          diff = [row, col]
          new_pos = [pos,diff].transpose.map { |arr| arr.reduce(:+) }
          possible << new_pos if @board.valid_pos?(new_pos)
        end
      end
    else
      key = [1, 2]

      4.times do
        new_pos = [pos, key].transpose.map { |arr| arr.reduce(:+) }
        possible << new_pos if @board.valid_pos?(new_pos)
                                      # [[4,5]] ; [[4,5], [2,5], [5,2]]
        row, col = key # [1,2] ; [2,-1] ; [-1,-2] ; [-2,1]
        row = -row # 1 => -1 ; 2 => -2
        key = [row, col] # [-1,2] ; [-2,-1] ; [1,-2] ; [2,1]
        new_pos = [pos, key].transpose.map { |arr| arr.reduce(:+) }
        possible << new_pos if @board.valid_pos?(new_pos)
                                        # [[4,5], [2,5], [5,2], [1, 2]]
        key = [col, row] # [-1,2] => [2,-1]
      end
    end

    possible - [pos]
  end

end
