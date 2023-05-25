
class Knight
  attr_accessor :position, :possible_moves

  def initialize(position=[], possible_moves=[] )
    @position = position
    @possible_moves = possible_moves
  end

  def calcMoves(current_position=position)
    newMoves = []

    newMoves << [ current_position[0]+2, current_position[1]+1 ] 
    newMoves << [ current_position[0]-2, current_position[1]+1 ]
    newMoves << [ current_position[0]+2, current_position[1]-1 ]
    newMoves << [ current_position[0]-2, current_position[1]-1 ]
    newMoves << [ current_position[0]+1, current_position[1]+2 ]
    newMoves << [ current_position[0]-1, current_position[1]+2 ]
    newMoves << [ current_position[0]+1, current_position[1]-2 ]
    newMoves << [ current_position[0]-1, current_position[1]-2 ]

  end

  def validateMoves(newMoves)
    newMoves.select! {|newMove| 
    newMove[0] <= 7 and newMove[0] >= 0 and 
    newMove[1] <= 7 and newMove[1] >= 0}
  end
end

class Board
  attr_accessor :board, :knight

  def initialize()
    @board = spawnBoard()
    @knight = Knight.new(position=spawnKnight())
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


  # Spawns a knight on random coordinate on chess board
  def spawnKnight()
    position = Array.new(2)
    position[0] = rand(0..7)
    position[1] = rand(0..7)
    puts toChessCoordinates(position)
    position
  end

  # Draws board and labels coordinates conventionally as per chess rules
  def drawBoard()
    board[self.knight.position[1]][self.knight.position[0]] = 1
    8.times do |i|
      puts "#{i+1} #{self.board[i]}"
    end
    puts "   A  B  C  D  E  F  G  H"
  end

  # Converts position array into chess coordinates as string
  def toChessCoordinates(position)
    row_ref = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    coordinate = ''

    coordinate << row_ref[position[0]]
    coordinate << (position[1] + 1).to_s
  end
end

board = Board.new()

board.drawBoard

test = board.knight.calcMoves
new_moves_test = board.knight.validateMoves(test)

for moves in new_moves_test
  puts board.toChessCoordinates(moves)
end