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

class SlidingPiece < Piece
  def moves
    moves = []

    directions.each do |direction|
      x, y = @position
      modx, mody = direction
      x += modx
      y += mody

      while @board.empty?([x, y])
        moves << [x, y]
        x += modx
        y += mody
      end

      moves << [x, y] if @board.enemy?([x, y], @color)
    end

    moves
  end

  def directions
    raise "Not Implemented yet!"
  end
end



class Bishop < SlidingPiece
  def directions
    DIAGONALS
  end
end

class Rook < SlidingPiece
  def directions
    MANHATTANS
  end
end

class Queen < SlidingPiece
  def directions
    DIAGONALS + MANHATTANS
  end
end

class SteppingPiece < Piece
  def moves
    moves = []

    variations.each do |variation|
      x, y = @position
      modx, mody = variation
      x += modx
      y += mody
      new_pos = [x, y]
      if @board.empty?(new_pos) || @board.enemy?(new_pos, @color)
        moves << new_pos
      end
    end

    moves
  end

  def variations
    raise "Not Implemented yet!"
  end
end

class King < SteppingPiece
  def variations
    DIAGONALS + MANHATTANS
  end
end

class Knight < SteppingPiece
  def variations
    a = [-1, 1].product([-2, 2])
    a += a.map(&:reverse)
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