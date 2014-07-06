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
  attr_accessor :size, :board

  def initialize(size)
    @size = size
    @board = make_board(size)
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

  def print_board
    @board.map { |row| puts row.join }
  end
  
  def get_large_number
    rand(2**32..2**640-1)**24
  end
end
