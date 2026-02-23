require_relative 'config/environment'

map '/users' do
  run UsersRoutes
end

map '/' do
  run BaseRoutes
end
