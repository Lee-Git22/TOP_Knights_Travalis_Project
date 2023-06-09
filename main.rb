
class Knight
  attr_accessor :position, :parent, :move_history

  MOVEMENT_PATTERN = [ [1,2], [-1,2], [1,-2], [-1, -2], [2,1], [-2,1], [2, -1], [-2, -1] ]
  # MOVEMENT_PATTERN = [ [1,1], [-1,-1], [1, -1], [-1, 1] ] # Kind of simulates bishop movement, provided target square and start square are same color 

  @@move_history = []

  def initialize(position=[], parent=nil)
    @position = position
    @parent = parent
    @@move_history << position
  end

  # Uses knight movement pattern to check next moves from current position
  def calcMoves(current_position=position)
    MOVEMENT_PATTERN.map { |pattern| [@position[0] + pattern[0], @position[1] + pattern[1]] }
                    .keep_if { |move| Knight.valid?(move) } # Ensures positions within the chess board
                    .reject { |move| @@move_history.include?(move) } # Prevents checking same positions again
                    .map { |move| Knight.new(move, self) } # Updates parent position and history of each position
  end

  def self.valid?(position)
    position[0].between?(0, 7) && position[1].between?(0, 7)
  end

end

class Board
  attr_accessor :board, :start, :target, :path

  def initialize()
    @board = spawnBoard()
    @start = [rand(0..7), rand(0..7)]  
    @target = [rand(0..7), rand(0..7)]
    @path = []
  end

  # Spawns an empty 8x8 array with 0s
  def spawnBoard()
    board = Array.new
    8.times do
      newRow = Array.new(8, 0)
      board << newRow
    end
    board
  end


  # Draws board and labels coordinates conventionally as per chess rules
  def drawBoard()

    # Labels the path to reach target
    pathCount = 1
    path.each { |position| board[position[1]][position[0]] = pathCount; pathCount += 1}

    8.times do |i|
      puts "#{i+1} #{self.board[i]}"
    end
    puts "   A  B  C  D  E  F  G  H"
  end

  # Converts position array into chess coordinates
  def toChessCoordinates(position)
    row_ref = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    coordinate = ''

    coordinate << row_ref[position[0]]
    coordinate << (position[1] + 1).to_s
  end

  # Displays the path sequentially
  def display_move_history(node)
    display_move_history(node.parent) unless node.parent.nil?
    @path << node.position 
    puts toChessCoordinates(node.position)
  end

  # Calculates the fastest route for knight using BFS searching algo and outputs the path
  def knight_moves(start_pos=@start, end_position=@target)
    queue = []
    current_node = Knight.new(start_pos)
    until current_node.position == end_position
      current_node.calcMoves.each { |child| queue.push(child) }
      current_node = queue.shift
    end
    
    display_move_history(current_node) 
    drawBoard()

  end

end

quickest_move = Board.new()
quickest_move.knight_moves()
