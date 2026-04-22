RSpec.describe "Fizzbuzz service" do
  it "should return valid fizzbuzz for different limits" do
    expected_return = ["1", "2", "fizz", "4", "buzz", "fizz", "7", "8", "fizz", "buzz", "11", "fizz", "13", "14", "fizzbuzz"]
    payload = {"int1" => 3, "int2" => 5, "limit" => 15, "str1" => "fizz", "str2" => "buzz"}

    expect(FizzbuzzService.fizzbuzz(payload)).to eq(expected_return)

    expected_return += ["16", "17", "fizz", "19", "buzz", "fizz", "22", "23", "fizz", "buzz"]
    payload["limit"] = 25
    expect(FizzbuzzService.fizzbuzz(payload)).to eq(expected_return)
  end

  it "should return valid fizzbuzz with custom values" do
    expected_return = ["1", "even", "3", "even", "5", "even", "7", "even", "9", "eventens", "11", "even", "13", "even", "15"]
    payload = {"int1" => 2, "int2" => 10, "limit" => 15, "str1" => "even", "str2" => "tens"}

    expect(FizzbuzzService.fizzbuzz(payload)).to eq(expected_return)
  end

  it "should return valid fizzbuzz with int1 and int2 greater than limit" do
    expected_return = ["1"]
    payload = {"int1" => 3, "int2" => 5, "limit" => 1, "str1" => "fizz", "str2" => "buzz"}

    expect(FizzbuzzService.fizzbuzz(payload)).to eq(expected_return)
  end

  it "should initialize and increment hits of requested payload" do
    payload = {"int1" => 3, "int2" => 5, "limit" => 15, "str1" => "fizz", "str2" => "buzz"}

    FizzbuzzService.fizzbuzz(payload)
    expect(Request.find_by(int1: 3, int2: 5, limit: 15, str1: "fizz", str2: "buzz").hits).to eq(1)

    FizzbuzzService.fizzbuzz(payload)
    expect(Request.find_by(int1: 3, int2: 5, limit: 15, str1: "fizz", str2: "buzz").hits).to eq(2)
  end
end
