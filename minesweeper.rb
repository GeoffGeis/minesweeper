require './board.rb'
require './mine.rb'
require './detector.rb'

class Minesweeper
  attr_accessor :debug, :board, :proxi, :mine_count, :mines, :row, :col, :detector

  def initialize(debug = true)
    @debug = debug
    puts "Minefield size:" 
    @board = Board.new
    @proxi = Board.new(@board.size)
    @mine_count = @board.size * 2
    @mines = (1..@mine_count).map { |i| i = Mine.new(@proxi) }
    @row = 0 
    @col = 0
    @detector = Detector.new(@board, @proxi)
    puts "Lets play minesweeper!"
    game
  end

  def game
    if @debug 
      @proxi.print_board
    end
    @board.print_board
    puts "pick a row:"
    @row = gets.chomp.to_i
    puts "pick a col:"
    @col = gets.chomp.to_i
    if (@row - 1 < 0 || @row - 1 > @proxi.size - 1) || (@col - 1 < 0 || @col - 1 > @proxi.size - 1)
      game
    end
    puts "flag position? (y/n)"
    flag = gets.chomp.downcase.to_s
    if flag == "y"
      flag_position
    else
      @detector.row = @row 
      @detector.col = @col 
      if @detector.mine? == true
        @proxi.print_board
        puts "game over"
        continue?
      end
      @detector.detect
      @detector.map_position
      @detector.recursion
      @detector.reset
      check_board
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
    @mine_count = @board.size * 2
    @mines = (1..@mine_count).map { |i| i = Mine.new(@proxi) }
    @row = 0 
    @col = 0
    @detector = Detector.new(@board, @proxi)
    game
  end
end

m = Minesweeper.new