ROW_REF = {
  'A' => 0,
  'B' => 1,
  'C' => 2,
  'D' => 3,
  'E' => 4,
  'F' => 5,
  'G' => 6,
  'H' => 7
}

class Knight
  attr_accessor :position, :possible_moves

  def initialize(position=[], possible_moves=[] )
    @position = position
    @possible_moves = possible_moves
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
    p position
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

end

board = Board.new()

board.drawBoard

