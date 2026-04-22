ENV["APP_ENV"] = "test"
require_relative "../config/loader"
require_relative "../app"

=begin
    Resets the test database before each test to prevent unexpected behaviors
=end
RSpec.configure do |config|
  config.before(:each) do
    ActiveRecord::Base.connection.tables.each do |table|
      next if table == "schema_migrations"

      ActiveRecord::Base.connection.execute("DELETE FROM #{table};")
    end
  end
end
