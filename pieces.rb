class Piece
  DIAGONALS = [[-1, -1],
               [-1, 1],
               [1, -1],
               [1, 1]]

  MANHATTANS = [[-1, 0],
                [1, 0],
                [0, -1],
                [0, 1]]

  attr_reader :color, :pos
  def initialize(color, pos, board)
    @color, @pos, @board = color, pos, board
    board[pos] = self
  end

  def moves
    raise "Not Implemented yet!"
  end

  def dup(new_board)
    self.class.new(@color, @pos, new_board)
  end

  def valid_moves
    moves.reject do |move|
      @board.dup.move!(self.pos, move).in_check?(@color)
    end
  end

  def pos=(pos)
    @board[@pos] = nil
    @board[pos] = self
    @pos = pos
  end
end