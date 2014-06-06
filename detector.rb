class Detector
  attr_accessor :proxi, :row, :col, :value

  def initialize(proxi)
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
    @value += 1 if @proxi.board[@row - 2][@col - 1] == "*"
    @value += 1 if @proxi.board[@row - 2][@col - 2] == "*"
    @value += 1 if @proxi.board[@row - 1][@col - 2] == "*"
    @value += 1 if @proxi.board[@row][@col - 2] == "*"
    @value += 1 if @proxi.board[@row][@col - 1] == "*"
    @value += 1 if @proxi.board[@row][@col] == "*"
    @value += 1 if @proxi.board[@row - 1][@col] == "*"
    @value += 1 if @proxi.board[@row - 2][@col] == "*"
  end

  def map_position
    @proxi.board[@row - 1][@col - 1] = @value
    @row = 0
    @col = 0
    @value = 0
  end
end