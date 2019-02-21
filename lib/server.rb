require 'sinatra'

get '/hello/:name' do
    "Hello #{params['name']}, how you doing"
end