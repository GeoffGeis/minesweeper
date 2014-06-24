class Mine
  def initialize(proxi)
    @proxi = proxi
    @row = 0
    @col = 0
    @random = Random.new
    check_position
  end

  def check_position
    if @proxi.board[@row - 1][@col - 1] != "L"
      @row = @random.rand(1..@proxi.board.length)
      @col = @random.rand(1..@proxi.board[0].length)
      check_position
    else
      map_position
    end
  end

  def map_position
    @proxi.board[@row - 1][@col - 1] = "*"
  end
end