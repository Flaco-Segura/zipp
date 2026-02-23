require 'spec_helper'
require 'json'

RSpec.describe Api::UsersRoutes, type: :request do
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  describe 'POST /api/users' do
    context 'with valid JSON payload' do
      let(:payload) do
        {
          first_name: 'API',
          last_name: 'Driver',
          email: 'driver@api.com'
        }.to_json
      end

      it 'creates a driver user and returns 201' do
        expect {
          post '/api/users', payload, headers
        }.to change { User.where(type: 'driver').count }.by(1)

        expect(last_response.status).to eq(201)
        response_body = JSON.parse(last_response.body)
        expect(response_body['message']).to eq('Driver created successfully')
        expect(response_body['user']['email']).to eq('driver@api.com')
        expect(response_body['user']['type']).to eq('driver')
      end
    end

    context 'with invalid email in JSON payload' do
      let(:payload) do
        {
          first_name: 'Bad',
          last_name: 'Email',
          email: 'not-an-email'
        }.to_json
      end

      it 'returns 422 with format error message' do
        expect {
          post '/api/users', payload, headers
        }.not_to change { User.count }

        expect(last_response.status).to eq(422)
        response_body = JSON.parse(last_response.body)
        expect(response_body['error']).to include('format is not valid')
      end
    end

    context 'with existing email' do
      before do
        User.create(first_name: 'Existing', last_name: 'API', email: 'exists@api.com', type: 'driver')
      end

      let(:payload) do
        {
          first_name: 'New',
          last_name: 'API',
          email: 'exists@api.com'
        }.to_json
      end

      it 'returns 409 conflict' do
        post '/api/users', payload, headers
        expect(last_response.status).to eq(409)
        response_body = JSON.parse(last_response.body)
        expect(response_body['error']).to eq('Email is already taken')
      end
    end
  end
end
