require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: ENV.fetch("DB_ADAPTER", "sqlite3"),
  database: ENV.fetch("DB_NAME", "db/development.sqlite3")
)
