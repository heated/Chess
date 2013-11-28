# what
require 'socket'

chess_server = TCPServer.new('localhost', 30000)
last_move = nil
loop do
  Thread.start(chess_server.accept) do |socket|
    puts "Turn started"

    new_move = socket.gets

    puts "Move received"

    socket.puts last_move

    last_move = new_move

    puts "Turn ended"
    socket.close
  end
end