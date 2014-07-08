class Position
  attr_reader :x, :y, :name 
  
  def initialize( x, y, name = '' )
    @name = name
    @x = x
    @y = y
  end
end