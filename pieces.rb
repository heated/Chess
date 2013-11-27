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
    @has_moved = false
    board[pos] = self
  end

  def dup(new_board)
    self.class.new(@color, @pos, new_board)
  end

  def valid_moves
    moves.reject do |move|
      new_board = @board.dup.move!(self.pos, move)
      new_board.in_check?(@color) || new_board.no_capture_roll == 50
    end
  end

  def pos=(pos)
    @board[@pos] = nil
    @board[pos] = self
    @pos = pos
    @has_moved = true
  end
end