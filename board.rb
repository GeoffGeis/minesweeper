require './position.rb'

class Board
  attr_accessor :board, :visual_board

  def initialize(size)
    # board  0 = empty | 1 = mine | 2 = flag
    @board = make_board(size)
    @random = Random.new
    # visual_board -1 = * (mine) | -2 = ! (flag) | -3 = L (untouched) | >= 0 numbers are counts of mines
    @visual_board = @board.map { |row| row.map { |e| -3 } }
    @mine_count = @board.size * 2
    (1..@mine_count).each { place_mine }
  end

  def size
    @board.length
  end

  def make_board(size)
    # [[0,0,0,0,0,0,0],[1,1,0,0,0,1,1],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0]]
    board = []
    (1..size).each do 
      row = []
      (1..size).each do 
        row << 0
      end
      board << row
    end
    board
  end
  
  def place_mine
    position = Position.new(@random.rand(1..size), @random.rand(1..size))
    if is_mine?(position)
      place_mine
    else
      @board[position.y-1][position.x-1] = 1
    end
  end
  
  def flag_position(position)
    @visual_board[position.y-1][position.x-1] = -2
    @mine_count -= 1 if @board[position.y-1][position.x-1] == 1
  end
  
  def has_won?
    dirty = false
    @visual_board.each do |row|
      dirty = row.any? { |e| e == -3 }
    end
    return @mine_count == 0 && !dirty
  end
  
  def is_mine?(position)
    @board[position.y-1][position.x-1] == 1
  end
  
  def is_valid_position?(position)
    position.x-1 < 0 || position.y-1 < 0 || @board[position.y-1][position.x-1] == nil
  end
  
  def print_debug_board
    @board.map { |row| puts row.join }
  end
  
  def reveal_board
    @board.each_with_index do |row, y|
      row.each_with_index do |col, x|
        datavalue = @board[y][x]
        @visual_board[y][x] = -1 if datavalue == 1 
      end
    end
    print_board
  end
  
  def print_board
    @visual_board.map do |row|
      visual = row.map do |space|
        case space
        when -1
          "*"
        when -2
          "!"
        when -3
          "."
        else
          "#{space}"
        end
      end
      puts visual.join
    end
    true
  end

  def detect(position)
    count = count_nearby(position)
    if count == 0
      floodfill(position)
    else
      @visual_board[position.y-1][position.x-1] = count
    end
  end
  
  #detect
  def detect(position)
    count = count_nearby(position)
    if count == 0
      # in this case had you chose anything this would never get called on the screen shot example since
      # all spots were near a mine anyone you chose would have a count > than 0
      floodfill(position)
    else
      # in this case (via array shown in the screenshot you sent) it will set it to 6 and not floodfill
      @visual_board[position.y-1][position.x-1] = count
    end
  end
  
  # clears out non mines
  def floodfill(position)
    target_number = 0
    # return if target_number == replacement_number
    # create an array to keep track of positions looked at 
    # -1 unprocessed -2 processed 
    processed = @board.map { |row| row.map { |e| -1 } }
    q = []
    q << position
    until q.empty?
      # Get a position
      n = q.pop
      # Filter out negative indexes
      next if n.y-1 < 0 || n.x-1 < 0
      # Check if this position is clear
      if @board[n.y-1][n.x-1] == target_number
        # if so set visual to what we want and initiate counting
        count = count_nearby(n)
        @visual_board[n.y-1][n.x-1] = count
        # update proccessed so we know we've seen it
        processed[n.y-1][n.x-1] = -2 
        next if count > 0
        # get directions to check
        to_check = get_four_directions(n)
        to_check.each do |direction|
          if processed[direction.y-1][direction.x-1] != nil && processed[direction.y-1][direction.x-1] == -1
            q << direction
          end
        end
      end
    end
  end
  
  def count_nearby(position)
    count = 0
    to_count = get_eight_directions(position)
    to_count.each do |direction|
      next if direction.y-1 < 0 || direction.x-1 < 0
      if @board[direction.y-1][direction.x-1] != nil && @board[direction.y-1][direction.x-1] == 1
        count += 1
      end
    end
    count
  end
  
  def get_eight_directions(start)
    x = start.x
    y = start.y
    directions = []
    directions << Position.new(x-1, y,'w')
    directions << Position.new(x+1, y,'e')
    directions << Position.new(x,y+1,'s')
    directions << Position.new(x,y-1,'n')
    directions << Position.new(x-1,y-1,'nw')
    directions << Position.new(x+1,y-1,'ne')
    directions << Position.new(x-1,y+1,'sw')
    directions << Position.new(x+1,y+1,'se')
    directions
  end

  def get_four_directions(start)
    x = start.x
    y = start.y
    directions = []
    directions << Position.new(x-1, y,'west')
    directions << Position.new(x+1, y,'east')
    directions << Position.new(x,y+1,'south')
    directions << Position.new(x,y-1,'north')
    directions
  end
end