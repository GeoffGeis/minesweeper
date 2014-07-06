class Integer
  def to_base(base=10)
    return [0] if zero?
    raise ArgumentError, 'base must be greater than zero' unless base > 0
    num = abs
    return [1] * num if base == 1
    [].tap do |digits|
      while num > 0
        digits.unshift num % base
        num /= base
      end
    end
  end
end

class Board
  attr_accessor :size, :board, :visual_board

  def initialize(size)
    @size = size
    # board  0 = empty | 1 = mine | 2 = flag
    @board = make_board(size)
    # visual_board -1 = L (empty) | -2 = ! (flag) | -3 = * (mine) | > 0 numbers are counts of mines
    @visual_board = @board.map { |row| row.map { |e| -1 } }
  end

  def make_board(size)
    binary = get_large_number.to_base 2
    field = []
    size.times do
      row = []
      size.times do
        row.push binary.pop
      end
      field.push row
    end
    field
  end
  
  def print_debug_board
    @board.map { |row| puts row.join }
  end
  
  def print_board
    @visual_board.map do |row|
      visual = row.map do |space|
        case space
        when -1
          "L"
        when -2
          "!"
        when -3
          "*"
        else
          space
        end
      end
      puts visual.join
    end
    true
  end
  
  def get_large_number
    rand(2**32..2**640-1)**24
  end
end
