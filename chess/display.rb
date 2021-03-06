require 'colorize'
require_relative 'cursor'
require_relative 'board'
require_relative 'piece'

class Display
  attr_reader :board
  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def highlight
    loop do
      render
      @cursor.get_input
    end
  end

  def render
    system("clear")

    board.grid.reverse.each_with_index do | row, row_idx |
      puts ""
      row.each_with_index do | piece, col_idx |
        if (row_idx + col_idx).odd?
          bkgd = :light_black
        else
          bkgd = :default
        end

        if [row_idx, col_idx] == @cursor.cursor_pos
          if @cursor.selected
            print "#{piece.symbol} ".colorize(mode: :bold, background: :red)
          else
            print "#{piece.symbol} ".colorize(mode: :bold, background: :light_cyan)
          end
        else
          print "#{piece.symbol} ".colorize(mode: :bold, background: bkgd)
        end
      end
    end


  end

end

if $PROGRAM_NAME == __FILE__
  screen = Display.new(Board.new_game)
  screen.highlight
end
