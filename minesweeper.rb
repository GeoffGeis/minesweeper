require './board.rb'
require './position.rb'

class NilClass
  def method_missing(*)
    nil
  end
end

class Minesweeper
  attr_reader :board

  def initialize(debug = false)
    @debug = debug
    start
  end

  def start
    puts "Minefield size:"
    size = gets.chop.to_i
    @board = Board.new(size)
    puts "Lets play minesweeper!"
    game
  end

  def game
    @board.print_debug_board if @debug
    puts '-------------'
    @board.print_board
    puts "pick a row:"
    row = gets.chomp.to_i
    puts "pick a col:"
    col = gets.chomp.to_i
    position = Position.new(col, row)
    game if @board.is_valid_position?(position)
    puts "flag position? (y/n)"
    flag = gets.chomp.downcase.to_s
    if flag == "y"
      @board.flag_position(position)
      win if @board.has_won?
    else
      lose if @board.is_mine?(position)
      @board.detect(position)
      win if @board.has_won?
    end
    game
  end
  
  def lose
    @board.reveal_board
    puts "you lose"
    continue?
  end
  
  def win
    @board.reveal_board
    puts "you win"
    continue?
  end
  
  def continue?
    puts "continue? (y/n)"
    continue = gets.chomp.downcase.to_s
    if continue == 'y'
      start
    else
      puts "see you later"
      exit
    end
  end 
end

m = Minesweeper.new(true)