class Board
  attr_accessor :size, :board

  def initialize(size = gets.chomp.to_i)
    @size = size
    @board = (1..@size).map { |x| ["L"] * @size }
  end

  def print_board
    @board.map { |row| puts row.join }
  end
end