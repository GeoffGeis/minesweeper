class Detector
  attr_accessor :proxi, :row, :col, :value

  def initialize(proxi)
    @proxi = proxi
    @row = row
    @col = col
    @value = 0
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
  end
end