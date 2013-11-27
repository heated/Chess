require_relative 'board.rb'

class Game
  attr_accessor :board
  def initialize(players)
    @white = players[:white]
    @black = players[:black]
    @board = Board.new
    setup_pieces
  end

  def setup_pieces
    positioning = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    8.times do |i|
      positioning[i].new(:b, [i, 0], @board)
      positioning[i].new(:w, [i, 7], @board)
      Pawn.new(:b, [i, 1], @board)
      Pawn.new(:w, [i, 6], @board)
    end
  end


  def play
    turn = 0
    until @board.over?
      p @board
      begin
        if turn.odd?
          @black.play_turn(@board, :b)
        else
          @white.play_turn(@board, :w)
        end
      rescue => e
        puts e.message
        retry
      end
      turn += 1
    end
  end
end

class HumanPlayer

  def initialize(name = "John")
    @name = name
  end

  def play_turn(board, color)
    puts "Pick a piece to move."
    piece_pos = gets.chomp.split(",").map(&:strip).map { |coord| Integer(coord) }
    raise "That isn't your piece!" if board.enemy?(piece_pos, color)
    raise "There is no piece there!" if board.empty?(piece_pos)
    raise "That is not even a coordinate" unless board.on_board?(piece_pos)
    puts "Where do you want to move to?"
    move_to_pos = gets.chomp.split(",").map(&:strip).map { |coord| Integer(coord) }
    board.move(piece_pos, move_to_pos)
  end
end

John = HumanPlayer.new("John")

Harold = HumanPlayer.new("Harold")

funtimes = Game.new({:white => John, :black => Harold})

funtimes.play