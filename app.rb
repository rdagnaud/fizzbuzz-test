require_relative "./config/loader"

register ErrorHandler

post "/fizzbuzz" do
  payload = JSON.parse(request.body.read)

  error = FizzbuzzValidator.validate_fizzbuzz(payload)

  halt 400, { error: "bad_request", message: error }.to_json if error

  response = FizzbuzzService.fizzbuzz(payload)

  status 200
  content_type :json
  response.to_json
end

get "/stats" do
  response = StatsService.stats

  if response
    status 200
    content_type :json
    response.to_json
  else
    status 204
  end
end