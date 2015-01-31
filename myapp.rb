# myapp.rb
require 'sinatra'

set :bind, '0.0.0.0'
set :port, 2974

get '/' do
  'Hello!'
end

get '/:newMode' do
  s = TCPSocket.open("127.0.0.1", "2973")
  to_send = "set pattern #{params[:newMode]}"
  puts to_send
  s.write(to_send)
  s.close
  "Changed mode to #{params[:newMode]}"
end
