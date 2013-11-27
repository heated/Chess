require_relative 'board.rb'
require_relative 'players.rb'


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
      begin
        puts "\n#{current_player} to play."
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

  def end_game
    if @board.draw?
      puts "game is a draw!"
    elsif @board.winner == :w
       puts "Congratulations, White wins!"
    else
       puts "Congratulations, Black wins!"
    end
  end
end

John = HumanPlayer.new("John")
Harold = ComputerPlayer.new("Harold")

funtimes = Game.new( {:w => John, :b => Harold} )
funtimes.play