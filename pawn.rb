# encoding: UTF-8
require_relative 'pieces.rb'

class Pawn < Piece
  def moves
    direction = (@color == :w ? -1 : 1)
    moves = []

    x, y = @pos
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

  def to_s
    @color == :w ? "♙" : "♟"
  end
end

