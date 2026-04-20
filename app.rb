require "sinatra"
require "sinatra/activerecord"
require "json"

require_relative "./src/services/fizzbuzz_service.rb"
require_relative "./src/validators/fizzbuzz_validator.rb"
require_relative "./src/errors/error_handler.rb"

register ErrorHandler

set :database_file, "config/database.yml"

post "/fizzbuzz" do
  payload = JSON.parse(request.body.read)

  FizzbuzzValidator.validate_fizzbuzz(payload)

  response = FizzbuzzService.fizzbuzz(payload)

  status 200
  content_type :json
  response.to_json
end

get "/stats" do
  response = StatsService.stats

  status 200
  content_type :json
  response.to_json
end
