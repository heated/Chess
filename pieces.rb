class Piece
  DIAGONALS = [[-1, -1],
               [-1, 1],
               [1, -1],
               [1, 1]]

  MANHATTANS = [[-1, 0],
                [1, 0],
                [0, -1],
                [0, 1]]

  attr_reader :color, :position
  def initialize(color, position, board)
    @color, @position, @board = color, position, board
    board[position] = self
  end

  def moves
    raise "Not Implemented yet!"
  end
end

class Pawn < Piece
  def moves
    direction = (@color == :w ? -1 : 1)
    moves = []

    x, y = @position
    y += direction

    moves << [x, y] if @board.empty?([x, y])

    [-1, 1].each do |xmod|
      new_x = x + xmod
      moves << [new_x, y] if @board.enemy?([new_x, y], @color)
    end

    y += direction

    if @color == :w
      moves << [x, y] if y == 4 && @board.empty?([x, y])
    else
      moves << [x, y] if y == 3 && @board.empty?([x, y])
    end

    moves
  end
end