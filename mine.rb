class Mine
  attr_accessor :proxi, :row, :col

  def initialize(proxi)
    @proxi = proxi
    @row = Random.rand(1..@proxi.board.length)
    @col = Random.rand(1..@proxi.board[0].length)
    check_position
  end

  def check_position
    if @proxi.board[@row - 1][@col - 1] != "L"
      initialize
    else
      map_position
    end
  end

  def map_position
    @proxi.board[@row - 1][@col - 1] = "*"
  end
end