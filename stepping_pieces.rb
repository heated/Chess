# encoding: UTF-8
require_relative 'pieces.rb'

class SteppingPiece < Piece
  def moves
    x, y = @pos

    variations
    .map { |(modx, mody)| [x + modx, y + mody] }
    .select do |new_pos|
      @board.empty?(new_pos) || @board.enemy?(new_pos, @color)
    end
  end
end

class King < SteppingPiece
  def to_s
    @color == :w ? "♔" : "♚"
  end

  private
  def variations
    DIAGONALS + MANHATTANS
  end
end

class Knight < SteppingPiece
  def to_s
    @color == :w ? "♘" : "♞"
  end

  private
  def variations
    a = [-1, 1].product([-2, 2])
    a += a.map(&:reverse)
  end
end