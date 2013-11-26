class Piece
  attr_reader :color, :position
  DIAGONALS = [[-1, -1],
               [-1, 1],
               [1, -1],
               [1, 1]]

  MANHATTANS = [[-1, 0],
                [1, 0],
                [0, -1],
                [0, 1]]
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

      while @board.on_board?([x, y]) && @board.empty?([x, y])
        moves << [x, y]
        x += modx
        y += mody
      end

      moves << [x, y] if @board.on_board?([x, y]) && @board[[x, y]].color != @color
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
    variations
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
    [[2, 1], [-2, 1]]


  end

end





class Pawn < Piece

end