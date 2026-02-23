require 'spec_helper'

RSpec.describe UsersRoutes, type: :request do
  describe 'GET /users/new' do
    it 'returns the new user form' do
      get '/users/new'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Create New Customer')
    end
  end

  describe 'POST /users' do
    context 'with valid parameters' do
      it 'creates a new customer' do
        expect {
          post '/users', { first_name: 'John', last_name: 'Doe', email: 'john@example.com' }
        }.to change { User.where(type: 'customer').count }.by(1)

        expect(last_response).to be_ok
        expect(last_response.body).to include('Customer created successfully')
      end
    end

    context 'with invalid email' do
      it 'shows an error and does not create user' do
        expect {
          post '/users', { first_name: 'John', last_name: 'Doe', email: 'invalid-email' }
        }.not_to change { User.count }

        expect(last_response).to be_ok
        expect(last_response.body).to include('format is not valid')
      end
    end

    context 'with duplicate email' do
      before do
        User.create(first_name: 'Jane', last_name: 'Doe', email: 'duplicate@example.com', type: 'customer')
      end

      it 'shows a duplicate email error' do
        post '/users', { first_name: 'John', last_name: 'Smith', email: 'duplicate@example.com' }
        expect(last_response.body).to include('Email is already taken')
      end
    end
  end
end
