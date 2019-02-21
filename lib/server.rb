require 'sinatra'
require_relative './game.rb'

get '/board' do
    reset()
    erb :board, :locals => {:display => $board, :message => "ready player one"}
end

get '/play/:position' do
    message = _play(params['position'])
    erb :board, :locals => {:display => $board, :message => message}
end

get '/' do
    send_file File.join(settings.public_folder, 'index.html')
end