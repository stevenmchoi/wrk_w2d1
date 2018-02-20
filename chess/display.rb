require 'colorize'
require_relative 'cursor.rb'
class Display
  attr_reader :board
  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def highlight
    loop do
      render
      self.cursor.get_input
    end
  end

  def render
    board.grid.reverse.each do | row |
      puts "--------------------------"
      print "|"

      row.each do | col |
        pos = [row,col]
        piece = board[pos]
        if pos == @cursor.cursor_pos
          if @cursor.selected
            print " #{piece.symbol} ".colorize(
              :mode => :bold, :color => piece.color,
              :background => :red)
          else
            print " #{piece.symbol} ".colorize(
              :color => piece.color,
              :background => :light_cyan)
          end
        else
          print " #{piece.symbol} ".colorize(:color => piece.color,
                                             :background => :light_black)
        end
      end

      print "|"
    end

    puts "--------------------------"
  end

end

if $PROGRAM_NAME == __FILE__
  screen = Display.new(Board.new_game)
  screen.render
end
