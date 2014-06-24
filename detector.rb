class Detector
  def initialize(board, proxi)
    @board = board
    @proxi = proxi
    @value = 0
  end

  def mine?(row, col)
    if @proxi.board[row - 1][col - 1] == "*"
      true
    else
      false
    end
  end

  def detect(row, col)
    (row - 1..row + 1).each do |r|
      (col - 1..col + 1).each do |c|
        unless (r - 1 < 0 || r - 1 > @proxi.size - 1) || (c - 1 < 0 || c - 1 > @proxi.size - 1)
          @value += 1 if @proxi.board[r - 1][c - 1] == "*"
          @proxi.board[row - 1][col - 1] = @value.to_s
          @board.board[row - 1][col - 1] = @value.to_s
        end
      end
    end
  end

  def reset
    @value = 0
  end
end