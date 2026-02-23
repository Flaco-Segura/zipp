ENV['APP_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['APP_ENV'].to_sym)

require_relative 'database'

Dir[File.join(__dir__, '../app/models/**/*.rb')].sort.each { |f| require f }
Dir[File.join(__dir__, '../app/routes/**/*.rb')].sort.each { |f| require f }
