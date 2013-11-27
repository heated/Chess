# encoding: UTF-8
require_relative 'pieces.rb'

class SteppingPiece < Piece
  def moves
    moves = []

    variations.each do |variation|
      x, y = @pos
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

  def to_s
    @color == :w ? "♔" : "♚"
  end
end

class Knight < SteppingPiece
  def variations
    a = [-1, 1].product([-2, 2])
    a += a.map(&:reverse)
  end

  def to_s
    @color == :w ? "♘" : "♞"
  end
end