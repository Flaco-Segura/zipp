require 'sinatra/base'

class BaseRoutes < Sinatra::Base
  configure do
    set :root, File.expand_path('../../', __dir__)
    set :views, File.expand_path('../../app/views', __dir__)
  end

  get '/' do
    'Hello from zipp! (MVC Modular Architecture)'
  end
end
