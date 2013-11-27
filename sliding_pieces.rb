# encoding: UTF-8
require_relative 'pieces.rb'

class SlidingPiece < Piece
  def moves
    moves = []

    directions.each do |direction|
      x, y = @pos
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
end

class Bishop < SlidingPiece
  def to_s
    @color == :w ? "♗" : "♝"
  end

  private
  def directions
    DIAGONALS
  end
end

class Rook < SlidingPiece
  def to_s
    @color == :w ? "♖" : "♜"
  end

  private
  def directions
    MANHATTANS
  end
end

class Queen < SlidingPiece
  def to_s
    @color == :w ? "♕" : "♛"
  end

  private
  def directions
    DIAGONALS + MANHATTANS
  end
end