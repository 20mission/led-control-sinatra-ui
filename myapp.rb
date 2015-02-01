# myapp.rb
require 'sinatra'
require 'active_support/all'

set :bind, '0.0.0.0'
set :port, 2974

get '/' do
  patterns = ["Volume", "LightsOff", "LightsOn", "MicrophonePulse", "FastMicrophonePulse", "Ants", "Spin", "Rainbow", "RainbowCandy", "Fade", "CrazyColorStrobe", "ColorStrobe", "Strobe", "TestPixel"] 
  result = "<html><body>"
  patterns.each do |p|
    result += "<div><a href='/newMode/#{p.underscore}'><button>#{p}</button></a></div>"
  end
  result += "</body></html>"
  result
end

get '/newMode/:newMode' do
  s = TCPSocket.open("127.0.0.1", "2973")
  to_send = "set pattern #{params[:newMode]}"
  puts to_send
  s.write(to_send)
  s.close
  "Changed mode to #{params[:newMode]}"
end

