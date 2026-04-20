module ErrorHandler
  def self.registered(app)
    app.error 400 do
      error = env['sinatra.error']

      status 400

      content_type :json
      {
        error: error.class.name,
        message: error.message
      }.to_json
    end

    app.error ActiveRecord::ActiveRecordError do
      error = env['sinatra.error']

      status 422

      content_type :json
      {
        error: error.class.name,
        message: error.message
      }.to_json
    end

    error do
      status 500

      content_type :json
      {
        error: "internal_server_error",
        message: "An unexpected error occured"
      }.to_json
    end
  end
end
