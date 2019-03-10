require 'sinatra'
require_relative './ai.rb'

set :bind, '0.0.0.0'

get '/' do
    send_file File.join(settings.public_folder, 'index.html')
end

get '/new-game' do
    erb :board, :locals => {:display => newBoard(), :message => "Ready player one", :playAgain => false}
end

get '/play/:position/:board' do
    boardAfterPlayer = makePlay("o", params['position'].to_i, params['board'])
    score = getScore(boardAfterPlayer, "o")

    if score == -100 then return erb :board, :locals => {:display => boardAfterPlayer, :message => "You win!", :playAgain => true} end
    if score == 0 then return erb :board, :locals => {:display => boardAfterPlayer, :message => "Draw", :playAgain => true} end
    
    computersPosition = getMove(boardAfterPlayer, "x")
    boardAfterComputer = makePlay("x", computersPosition, boardAfterPlayer)
    score = getScore(boardAfterComputer, "x")

    if score == 100 then return erb :board, :locals => {:display => boardAfterComputer, :message => "I win!", :playAgain => true} end
    if score == 0 then return erb :board, :locals => {:display => boardAfterComputer, :message => "Draw", :playAgain => true} end

    erb :board, :locals => {:display => boardAfterComputer, :message => " ", :playAgain => false}
end