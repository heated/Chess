require_relative 'board.rb'
require_relative 'players.rb'
require 'socket'

class Game
  attr_accessor :board
  def initialize(players)
    @players = players
    @board = Board.new
    setup_pieces
  end

  def play
    current_player = :w
    until @board.over?
      puts @board
      puts "\n#{print_current_player(current_player)} to play."
      begin
        @players[current_player].play_turn(@board, current_player)
      rescue => e
        puts e.message
        retry
      end

      current_player = (current_player == :w ? :b : :w)
    end

    end_game
  end

  private
  def setup_pieces
    positioning = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    8.times do |i|
      positioning[i].new(:b, [i, 0], @board)
      positioning[i].new(:w, [i, 7], @board)
      Pawn.new(:b, [i, 1], @board)
      Pawn.new(:w, [i, 6], @board)
    end
  end

  def print_current_player(color)
    color == :w ? "White" : "Black"
  end

  def end_game
    if @board.draw?
      puts "game is a draw!"
    else
      puts "Congratulations, #{@players[@board.winner].name} wins!"
    end
  end
end

John = HumanPlayer.new("John")
Harold = ComputerPlayer.new("Harold")
Hateful = InternetPlayer.new("Anonymous")

funtimes = Game.new( {:w => John, :b => Hateful} )
funtimes.play