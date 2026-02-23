ENV['APP_ENV'] = 'test'
ENV['DATABASE_URL'] ||= 'postgres://zipp:zipp_secret@localhost:5432/zipp_development'

require_relative '../config/environment'
require 'rspec'
require 'rack/test'
require 'database_cleaner/sequel'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner[:sequel].db = DB
    DatabaseCleaner[:sequel].strategy = :transaction
    DatabaseCleaner[:sequel].clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner[:sequel].cleaning do
      example.run
    end
  end

  def app
    Rack::Builder.parse_file(File.expand_path('../config.ru', __dir__))
  end
end
