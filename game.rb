require_relative 'board.rb'
require_relative 'players.rb'

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
      puts @board
      begin
        if turn.odd?
          puts "\nBlack to play."
          @black.play_turn(@board, :b)
        else
          puts "\nWhite to play."
          @white.play_turn(@board, :w)
        end
      rescue => e
        puts e.message
        retry
      end
      turn += 1
    end
    print ", "
    if @board.winner == :w
       puts "Congratulations, White wins!"
    else
       puts "Congratulations, Black wins!"
    end
  end
end

John = HumanPlayer.new("John")

Harold = HumanPlayer.new("Harold")

funtimes = Game.new({:white => John, :black => Harold})

funtimes.play