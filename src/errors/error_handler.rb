
  error BadRequestError do
    error = env['sinatra.error']

    status error.status

    content_type :json
    {
        error: error.class.name,
        message: error.message
    }.to_json
  end

  error ActiveRecord::ActiveRecordError do
    error = env['sinatra.error']

    status 400

    content_type:json
  end