require_relative '../../config/database'
require "fileutils"

MIGRATIONS_DIR = File.expand_path("../../db/migrations", __dir__)

namespace :db do
  desc "Run pending migrations"
  task :migrate do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, MIGRATIONS_DIR)
    puts "✅ Migrations applied successfully."
  end

  desc "Rollback last migration"
  task :rollback do
    Sequel.extension :migration
    current = Sequel::Migrator.run(DB, MIGRATIONS_DIR, target: 0)
    puts "⏪ Rolled back to version #{current}."
  end

  desc "Show current migration version"
  task :version do
    version = DB[:schema_migrations].order(:filename).last&.fetch(:filename, "none") rescue "none"
    puts "📌 Current migration version: #{version}"
  end

  desc "Drop and recreate the database schema (destructive!)"
  task :reset => [:rollback, :migrate]
end
