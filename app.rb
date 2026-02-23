require 'sinatra/base'

class App < Sinatra::Base
  get '/' do
    'Hello from zipp!'
  end
end
