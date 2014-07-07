require './board.rb'
require './mine.rb'
require './detector.rb'
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
    puts "Minefield size:"
    size = gets.chop.to_i
    @board = Board.new size
    # @detector = Detector.new(@board, @proxi)
    puts "Lets play minesweeper!"
    game
  end

  def game
    if @debug 
      @board.print_debug_board
    end
    @board.print_board
    puts "pick a row:"
    row = gets.chomp.to_i
    puts "pick a col:"
    col = gets.chomp.to_i
    position = Position.new col, row
    game if @board.is_valid_position?(position)
    
    puts "flag position? (y/n)"
    flag = gets.chomp.downcase.to_s
    if flag == "y"
      @board.flag_position position
    else
      if @board.is_mine?(position)
        # TODO reveal board
        puts "game over"
        continue?
      end
      @board.detect position
      @board.check_board
    end
  end

  def flag_position
    if @proxi.board[@row - 1][@col - 1] == "*"
      @mine_count -= 1
      @board.board[@row - 1][@col - 1] = "!"
      check_board
    else
      @board.board[@row - 1][@col - 1] = "!"
      game
    end
  end

  def check_board
    if @mine_count == 0 
      unless ["L"].any? { @proxi.board }
        game
      end
      @proxi.print_board
      puts "you win"
      continue?
    else
      game
    end
  end

  def continue?
    puts "continue? (y/n)"
    continue = gets.chomp.downcase.to_s
    if continue == 'y'
      reset
    else
      puts "see you later"
      exit
    end
  end

  def reset
    puts "Minefield size:" 
    @board = Board.new
    @proxi = Board.new(@board.size)
    mine_count = @board.size * 2
    (1..mine_count).each { |i| i = Mine.new(@proxi) }
    @row = 0 
    @col = 0
    @detector = Detector.new(@board, @proxi)
    game
  end
end
