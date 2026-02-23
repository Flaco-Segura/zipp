require 'sinatra/base'

class BaseRoutes < Sinatra::Base
  configure do
    set :root, File.expand_path('../../', __dir__)
    set :views, File.expand_path('../../app/views', __dir__)
    set :public_folder, File.expand_path('../../public', __dir__)
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET', 'a_super_secret_key_for_development_that_is_at_least_sixty_four_characters_long_for_rack_session_to_be_happy')
  end

  get '/' do
    @notice = session.delete(:notice)
    erb :'sessions/new'
  end

  post '/login' do
    user = User.find(email: params['email'])
    if user
      session[:user_id] = user.id
      "Logged in as #{user.first_name}"
    else
      @error = "Invalid email"
      erb :'sessions/new'
    end
  end
end
