require_relative "../config/database.rb"

env = ENV.fetch("APP_ENV", "development")
abort("Cannot reset production database") if env == "production"

ActiveRecord::Base.connection.tables.each do |table|
  next if table == "schema_migrations"

  ActiveRecord::Base.connection.execute("DELETE FROM #{table};")
end

puts "DB cleared ✅"
