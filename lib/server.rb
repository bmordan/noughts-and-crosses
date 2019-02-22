require 'sinatra'
require_relative './game.rb'

set :bind, '0.0.0.0'

get '/board' do
    reset()
    erb :board, :locals => {:display => $board, :message => "ready player one", :playAgain => false}
end

get '/play/:position' do
    message = _play(params['position'])
    status = message.split(//).last(5).join()
    playAgain = status == "wins!" || status == "draw!"
    erb :board, :locals => {:display => $board, :message => message, :playAgain => playAgain}
end

get '/' do
    send_file File.join(settings.public_folder, 'index.html')
end