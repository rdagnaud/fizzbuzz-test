module ErrorHandler
  def self.registered(app)
    app.error ActiveRecord::ActiveRecordError do
      error = env["sinatra.error"]

      status 422

      content_type :json
      {
        error: error.class.name,
        message: error.message
      }.to_json
    end

    app.error JSON::ParserError do
      status 400

      content_type :json
      {
        error: "bad_request",
        message: "Invalid JSON"
      }.to_json
    end

    app.error do
      status 500

      content_type :json
      {
        error: "internal_server_error",
        message: "An unexpected error occured"
      }.to_json
    end
  end
end
