require "bundler/setup"
Bundler.require(:default, ENV.fetch("APP_ENV", "development").to_sym)

require_relative "./database"

Dir[File.join(__dir__, "../src/**/*.rb")].sort.each do |file|
  require file
end
