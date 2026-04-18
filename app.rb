require "sinatra"
require_relative "./src/services/fizzbuzz_service.rb"
require_relative "./src/validators/fizzbuzz_validator.rb"

post "/fizzbuzz" do
    payload = JSON.parse(request.body.read)

    is_valid, error = FizzbuzzValidator.validate_fizzbuzz(payload)

    raise error if is_valid

    response = FizzbuzzService.fizzbuzz(payload)

    content_type :json
    response.to_json
end
