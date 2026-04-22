RSpec.describe "Stats service" do
  it "should return nothing if no request in the database" do
    expect(StatsService.stats).to eq(nil)
  end

  it "should return the highest hit request with correct hits number" do
    Request.create!(int1: 2, int2: 10, limit: 25, str1: "even", str2: "tens", hits: 3)
    expected_request = Request.create!(int1: 3, int2: 5, limit: 25, str1: "fizz", str2: "buzz", hits: 5)
    expect(StatsService.stats).to eq(expected_request.as_json(except: [:id, :created_at, :updated_at]))
  end
end
