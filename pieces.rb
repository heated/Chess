class Piece
  DIAGONALS = [[-1, -1],
               [-1, 1],
               [1, -1],
               [1, 1]]

  MANHATTANS = [[-1, 0],
                [1, 0],
                [0, -1],
                [0, 1]]

  attr_reader :color, :pos, :has_moved
  def initialize(color, pos, board)
    @color, @pos, @board = color, pos, board
    @has_moved = false
    board[pos] = self
  end

  def dup(new_board)
    self.class.new(@color, @pos, new_board)
  end

  def valid_moves
    moves.reject do |move|
      @board.dup.move!(self.pos, move).in_check?(@color)
    end
  end

  def has_moved?
    @has_moved
  end

  def pos=(pos)
    @board[@pos] = nil
    @board[pos] = self
    @pos = pos
    @has_moved = true
  end
end