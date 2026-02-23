require_relative 'base'

class UsersRoutes < BaseRoutes
  get '/new' do
    erb :'users/new'
  end

  post '/' do
    @user = User.new(
      first_name: params['first_name'],
      last_name: params['last_name'],
      email: params['email'],
      type: 'customer'
    )
    
    if @user.valid?
      begin
        @user.save
        "Customer created successfully! ID: #{@user.id}"
      rescue Sequel::UniqueConstraintViolation
        @error = "Email is already taken"
        erb :'users/new'
      end
    else
      @error = @user.errors.full_messages.join(', ')
      erb :'users/new'
    end
  end

  get '/' do
    content_type :json
    User.all.map(&:values).to_json
  end
end
