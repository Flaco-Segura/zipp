require 'json'
require_relative '../base'

module Api
  class UsersRoutes < ::BaseRoutes
    post '/' do
      content_type :json
      
      begin
        payload = JSON.parse(request.body.read)
        user = User.new(
          first_name: payload['first_name'],
          last_name: payload['last_name'],
          email: payload['email'],
          type: 'driver'
        )
        
        if user.valid?
          user.save
          status 201
          { message: 'Driver created successfully', user: user.values }.to_json
        else
          status 422
          { error: user.errors.full_messages.join(', ') }.to_json
        end
      rescue Sequel::UniqueConstraintViolation
        status 409
        { error: 'Email is already taken' }.to_json
      rescue JSON::ParserError
        status 400
        { error: 'Invalid JSON body' }.to_json
      end
    end
  end
end
