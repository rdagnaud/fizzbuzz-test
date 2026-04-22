RSpec.describe "App" do
  include Rack::Test::Methods

  def app
    App
  end

  describe "POST /fizzbuzz" do
    it "should respond 200 with valid payload" do
      allow(FizzbuzzValidator).to receive(:validate).and_return(nil)
      allow(FizzbuzzService).to receive(:fizzbuzz).and_return("1")

      post "/fizzbuzz", { int1: 3, int2: 5, limit: 15, str1: "fizz", str2: "buzz" }.to_json, { "CONTENT_TYPE" => "application/json" }

      expect(last_response.status).to eq(200)

      json = JSON.parse(last_response.body)

      expect(json).to eq("1")
    end
    
    it "should respond 400 if validation fails with FizzbuzzValidator's message" do
      allow(FizzbuzzValidator).to receive(:validate).and_return("failed validation")

      post "/fizzbuzz", { int1: 3, int2: 5, limit: 15, str1: "fizz", str2: "buzz" }.to_json, { "CONTENT_TYPE" => "application/json" }

      expect(last_response.status).to eq(400)

      json = JSON.parse(last_response.body)

      expect(json["error"]).to eq("bad_request")
      expect(json["message"]).to eq("failed validation")
    end
  end

  describe "GET /stats" do
    it "should respond 200 if a request has been found and return StatsService's response" do
      allow(StatsService).to receive(:stats).and_return("found")

      get "/stats"

      expect(last_response.status).to eq(200)

      json = JSON.parse(last_response.body)

      expect(json).to eq("found")
    end

    it "should respond 204 if no request has been found" do
      allow(StatsService).to receive(:stats).and_return(nil)

      get "/stats"

      expect(last_response.status).to eq(204)
    end
  end
end
