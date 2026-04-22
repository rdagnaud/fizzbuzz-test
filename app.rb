require_relative "./config/loader"

class App < Sinatra::Base
  # Used to be able to catch errors in error_handler to respond a custom internal_server_error message
  # instead of the full trace
  # Without this, Sinatra bypasses the error_handler
  configure do
    set :raise_errors, false
    set :show_exceptions, false
  end

  register ErrorHandler

  post "/fizzbuzz" do
    payload = JSON.parse(request.body.read)

    error = FizzbuzzValidator.validate(payload)

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
end
