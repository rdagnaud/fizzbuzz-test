require "bundler/setup"
Bundler.require

require_relative "./database"

Dir[File.join(__dir__, "../src/**/*.rb")].sort.each do |file|
  require file
end
