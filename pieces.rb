class Piece
  attr_reader :color, :position
  def initialize(color, position, board)
    @color, @position, @board = color, position, board
  end

  def moves
    raise "Not implemented yet"
  end

end

class SlidingPiece

end

class SteppingPiece

end

class Bishop < SlidingPiece
end

class Rook < SlidingPiece
end

class Queen < SlidingPiece
end

class King < SteppingPiece
end

class Knight < SteppingPiece
end





class Pawn < Piece

end