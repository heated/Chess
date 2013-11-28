require_relative 'pieces.rb'
require_relative 'sliding_pieces.rb'
require_relative 'stepping_pieces.rb'
require_relative 'pawn.rb'
require 'colorize'

class Board
  attr_reader :last_jump, :no_capture_roll, :cursor, :last_move
  def initialize(no_capture_roll = 0)
    @grid = Array.new(8) { Array.new(8) }
    @no_capture_roll = no_capture_roll
    @cursor = [4, 7]
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

  def cursor=(pos)
    on_board?(pos) && @cursor = pos
  end

  def in_check?(color)
    king = pieces(color).select { |piece| piece.is_a?(King) }.first

    pieces(color == :w ? :b : :w).any? do |piece|
      if piece.is_a?(King)
        piece.moves(true).include?(king.pos)
      else
        piece.moves.include?(king.pos)
      end
    end
  end

  def pieces(color)
    @grid.flatten.select { |piece| piece && piece.color == color }
  end

  def all_pieces
    pieces(:b) + pieces(:w)
  end

  def dup
    new_board = Board.new(@no_capture_roll)
    all_pieces.each { |piece| piece.dup(new_board) }
    new_board
  end

  def move(start_pos, end_pos)
    piece = self[start_pos]
    unless piece.nil?
      raise "You can't make that move!" unless piece.moves.include?(end_pos)
      raise "You can't move into check!" unless piece.valid_moves.include?(end_pos)
      @no_capture_roll += 1

      if piece.is_a?(Pawn)
        @no_capture_roll = 0
        self[[end_pos[0], piece.pos[1]]] = nil if end_pos == @last_jump
      end

      @no_capture_roll = 0 unless self.empty?(end_pos)

      handle_castle(end_pos, piece)
      pawn_jump(end_pos, piece)
      piece.pos = end_pos
      @last_move = [start_pos, end_pos]
    end
    pawn_promotion(piece)

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

  def over?
    checkmate?(:w) || checkmate?(:b) || draw?
  end

  def winner
    checkmate?(:w) ? :b : :w
  end

  def draw?
    no_moves = [:w, :b].any? do |color|
      pieces(color).all? { |piece| piece.valid_moves.size == 0 } &&
      !in_check?(color)
    end
    no_moves || @no_capture_roll >= 50
  end

  def show_moves(pos)
    @showing_moves = self[pos].valid_moves
  end

  def hide_moves
    @showing_moves = nil
  end

  def to_s

    str = "\e[H\e[2Jx  a b c d e f g h \n"
    @grid.size.times do |y|
      str << "\n" + (8 - y).to_s + " "

      @grid.size.times do |x|

        if self[[x, y]]
          new_str =  self[[x, y]].to_s + " "
        else
          new_str =  "  "
        end

        if @cursor == [x, y]
          str << new_str.black.on_blue
        elsif @showing_moves && @showing_moves.include?([x, y])
          str << new_str.black.on_yellow
        else
          str << ((x+y).even? ? new_str.black.on_white : new_str.black.on_green)
        end
      end
    end

    str
  end

  private
  def handle_castle(end_pos, piece)
    modx = piece.pos[0] - end_pos[0]
    if piece.is_a?(King) && modx.abs == 2
      x, y = piece.pos
      rook_x = (modx == -2 ? x + 3 : x - 4)

      jump_x = (x + end_pos[0]) / 2

      self[[rook_x, y]].pos = [jump_x, y]
    end
  end

  def pawn_jump(end_pos, piece)
    if piece.is_a?(Pawn) && (piece.pos[1] - end_pos[1]).abs == 2
      jump_y = (piece.pos[1] + end_pos[1]) / 2
      @last_jump = [end_pos[0], jump_y]
    else
      @last_jump = nil
    end
  end

  def pawn_promotion(piece)
    if piece.is_a?(Pawn)
      if (piece.color == :w && piece.pos[1] == 0) ||
         (piece.color == :b && piece.pos[1] == 7)
        Queen.new(piece.color, piece.pos, self)
      end
    end
  end
end