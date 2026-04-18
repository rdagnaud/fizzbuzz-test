require "sinatra"
require_relative "./src/services/fizzbuzz_service.rb"

post "/fizzbuzz" do
    payload = JSON.parse(request.body.read)

    FizzbuzzService.call
end
