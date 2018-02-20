require 'colorize'
require_relative 'cursor.rb'
class Display
  def initialize(board)
    @cursor = Cursor.new([0,0], board)
  end

  def highlight
    loop do
      render
      self.cursor.get_input
    end
  end

  def render

  end
end
