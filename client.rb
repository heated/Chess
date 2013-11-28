require 'socket'

hostname = 'localhost'
port = 30000

loop do
  message = gets.chomp
  socket = TCPSocket.open(hostname, port)

  puts socket.gets
  socket.puts message
end