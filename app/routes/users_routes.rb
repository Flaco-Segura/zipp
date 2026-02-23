class UsersRoutes < BaseRoutes
  get '/' do
    content_type :json
    User.all.map(&:values).to_json
  end
end
