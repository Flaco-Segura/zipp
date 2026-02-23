require "sequel"
require "fileutils"

MIGRATIONS_DIR = File.expand_path("db/migrations", __dir__)
DATABASE_URL   = ENV.fetch("DATABASE_URL", "postgres://zipp:zipp_secret@localhost:5432/zipp_development")

namespace :db do
  desc "Run pending migrations"
  task :migrate do
    db = Sequel.connect(DATABASE_URL)
    Sequel::Migrator.run(db, MIGRATIONS_DIR)
    puts "✅ Migrations applied successfully."
    db.disconnect
  end

  desc "Rollback last migration"
  task :rollback do
    db = Sequel.connect(DATABASE_URL)
    current = Sequel::Migrator.run(db, MIGRATIONS_DIR, target: 0)
    puts "⏪ Rolled back to version #{current}."
    db.disconnect
  end

  desc "Show current migration version"
  task :version do
    db = Sequel.connect(DATABASE_URL)
    version = db[:schema_migrations].order(:filename).last&.fetch(:filename, "none") rescue "none"
    puts "📌 Current migration version: #{version}"
    db.disconnect
  end

  desc "Drop and recreate the database schema (destructive!)"
  task :reset => [:rollback, :migrate]
end
