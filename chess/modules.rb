module SlidingPiece
  private
  def horizontal(pos)
    possible = []

    8.times do |idx|
      possible << [pos.first, idx]
    end

    possible - [pos]
  end

  def vertical(pos)
    possible = []

    8.times do |idx|
      possible << [idx, pos.last]
    end

    possible - [pos]
  end

  def diagonal(orig_pos)
    possible = []

    pos = orig_pos.dup
    #up-right
    loop do
      pos.map! { |el| el + 1 }
      if @board.valid_pos?(pos)
        possible << pos
      else
        break
      end
    end

    pos = orig_pos.dup
    #down-left
    loop do
      pos.map! { |el| el - 1 }
      if @board.valid_pos?(pos)
        possible << pos
      else
        break
      end
    end

    pos = orig_pos.dup
    #down-right
    loop do
      row, col = pos
      pos = [row - 1, col + 1 ]
      if @board.valid_pos?(pos)
        possible << pos
      else
        break
      end
    end

    pos = orig_pos.dup
    #up-left
    loop do
      row, col = pos
      pos = [row + 1, col - 1 ]
      if @board.valid_pos?(pos)
        possible << pos
      else
        break
      end
    end

    possible
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
