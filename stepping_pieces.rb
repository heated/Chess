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


  def moves(threatening = false) # calls in_check
    if threatening
      super()
    else
      super() + castle_moves
    end
  end

  private
  def variations
    DIAGONALS + MANHATTANS
  end

  def castle_moves # calls in_check
    c_moves = []

    unless has_moved? || @board.in_check?(@color)
      left_rook = @board[[0, @pos[1]]]
      right_rook = @board[[7, @pos[1]]]

      [left_rook, right_rook].each do |rook|
        unless rook.nil? || rook.has_moved?
          if castleable_rook?(rook)
            x, y = @pos
            if x < rook.pos[0]
              x += 2
            else
              x -= 2
            end
            c_moves << [x, y]
          end
        end
      end

    end
    c_moves
  end

  def castleable_rook?(rook)
    x, y = @pos
    xmod = rook.pos[0] - x
    xmod /= xmod.abs

    castling_moves = []

    until [x, y] == rook.pos
      x += xmod
      castling_moves << [x, y]
    end

    castling_moves.pop

    if castling_moves.all? { |move| @board.empty?(move) }
      unless @board.dup.move!(self.pos, castling_moves.first).in_check?(@color)
        return true
      end
    end

    false
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