RSpec.describe "Error handler" do
  include Rack::Test::Methods

  def app
    App
  end

  it "should return 422 status code on ActiveRecord error" do
    allow(FizzbuzzService).to receive(:fizzbuzz).and_raise(ActiveRecord::ActiveRecordError.new("db error"))

    post "/fizzbuzz", { int1: 3, int2: 5, limit: 15, str1: "fizz", str2: "buzz" }.to_json, { "CONTENT_TYPE" => "application/json" }

    expect(last_response.status).to eq(422)

    json = JSON.parse(last_response.body)

    expect(json["error"]).to eq("ActiveRecord::ActiveRecordError")
    expect(json["message"]).to eq("db error")
  end

  it "should return 500 status code on unexpected error" do
    allow(FizzbuzzService).to receive(:fizzbuzz).and_raise(StandardError.new("fail"))

    post "/fizzbuzz", { int1: 3, int2: 5, limit: 15, str1: "fizz", str2: "buzz" }.to_json, { "CONTENT_TYPE" => "application/json" }

    expect(last_response.status).to eq(500)

    json = JSON.parse(last_response.body)

    expect(json["error"]).to eq("internal_server_error")
    expect(json["message"]).to eq("An unexpected error occured")
  end
end
