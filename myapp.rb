# myapp.rb
require "rack/cache"
require 'sinatra'
require 'active_support/all'


set :bind, '0.0.0.0'
set :port, 2974

use Rack::Cache

set :static, true
set :static_cache_control, [:public, :max_age => 36000]

get '/' do
  cache_control :public, :max_age => 36000
  erb :index
end

get '/newMode/:newMode' do
  s = TCPSocket.open("courtyard-leds.local", "2973")
  to_send = "set pattern #{params[:newMode]}"
  puts to_send
  s.write(to_send)
  s.close
  redirect "/", 302
end

