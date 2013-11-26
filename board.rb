require_relative 'pieces.rb'
require_relative 'sliding_pieces.rb'
require_relative 'stepping_pieces.rb'
require_relative 'pawn.rb'

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def empty?(pos)
    on_board?(pos) &&
    self[pos].nil?
  end

  def on_board?(pos)
    pos.all? { |coord| coord >= 0 && coord < 8 }
  end

  def enemy?(pos, color)
    unless empty?(pos)
      self[pos].color != color if on_board?(pos)
    end
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, piece)
    @grid[pos[0]][pos[1]] = piece
  end

  def in_check?(color)
    king = pieces(color).select { |piece| piece.is_a?(King) }.first
    pieces(color == :w ? :b : :w).any? { |piece| piece.moves.include?(king.pos) }
  end

  def pieces(color)
    @grid.flatten.select { |piece| piece && piece.color == color }
  end

  def all_pieces
    pieces(:b) + pieces(:w)
  end

  def dup
    new_board = Board.new
    all_pieces.each { |piece| piece.dup(new_board) }
    new_board
  end

  def move(start_pos, end_pos)
    piece = self[start_pos]
    unless piece.nil?
      raise "You can't make that move!" unless piece.moves.include?(end_pos)
      raise "You can't move into check!" unless piece.valid_moves.include?(end_pos)
      piece.pos = end_pos
    end
    self
  end

  def move!(start_pos, end_pos)
    piece = self[start_pos]
    piece.pos = end_pos
    self
  end

  def checkmate?(color)
    in_check?(color) && pieces(color).all? { |piece| piece.valid_moves.size == 0 }
  end

end

funtimes = Board.new
castleman = Rook.new(:w, [7, 0], funtimes)
kingman = King.new(:b, [0,0], funtimes)
queenlady = Queen.new(:w, [0,2], funtimes)
p funtimes.checkmate?(:b)

