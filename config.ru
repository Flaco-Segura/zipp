require_relative 'config/environment'

map '/api/users' do
  run Api::UsersRoutes
end

map '/users' do
  run UsersRoutes
end

map '/' do
  run BaseRoutes
end
