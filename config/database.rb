require 'sequel'

DATABASE_URL = ENV.fetch("DATABASE_URL", "postgres://zipp:zipp_secret@localhost:5432/zipp_development")
DB = Sequel.connect(DATABASE_URL)

require 'logger'
DB.loggers << Logger.new($stdout)
