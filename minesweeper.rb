require './board.rb'
require './mine.rb'
require './detector.rb'

class Minesweeper
  attr_accessor :board, :proxi, :mines, :row, :col, :detector

  def initialize
    puts "Minefield size:" 
    @board = Board.new
    @proxi = Board.new(@board.size)
    puts "Mine count:"
    @mines = (1..@board.size * 2).map { |i| i = Mine.new(@proxi) }
    @row = 0 
    @col = 0
    @detector = Detector.new(@proxi)
    game
  end

  def game
  end
end

m = Minesweeper.new