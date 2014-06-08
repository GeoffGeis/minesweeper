class Detector
  attr_accessor :board, :proxi, :row, :col, :value

  def initialize(board, proxi)
    @board = board
    @proxi = proxi
    @row = 0
    @col = 0
    @value = 0
  end

  def mine?
    if @proxi.board[@row - 1][@col - 1] == "*"
      true
    else
      false
    end
  end

  def detect
    (@row - 1..@row + 1).each do |r|
      (@col - 1..@col + 1).each do |c|
        unless (r - 1 < 0 || r - 1 > @proxi.size - 1) || (c - 1 < 0 || c - 1 > @proxi.size - 1)
          @value += 1 if @proxi.board[r - 1][c - 1] == "*"
        end
      end
    end
  end

  def map_position
    @proxi.board[@row - 1][@col - 1] = @value
    @board.board[@row - 1][@col - 1] = @value
  end

  def recursion
    if @proxi.board[@row - 1][@col - 1] == "0"
      (@row - 1..@row + 1).each do |r|
        (@col - 1..@col + 1).each do |c|
          unless (r - 1 < 0 || r - 1 > @proxi.size - 1) || (c - 1 < 0 || c - 1 > @proxi.size - 1)
            @row, @col = r, c
            detect
            map_position
            recursion
          end
        end
      end
    end
  end

  def reset
    @row, @col, @value = 0, 0, 0
  end
end