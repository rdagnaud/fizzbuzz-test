require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: ENV.fetch("DB_ADAPTER", "sqlite3"),
  database: "db/#{ENV.fetch("APP_ENV", "development")}.sqlite3"
)
