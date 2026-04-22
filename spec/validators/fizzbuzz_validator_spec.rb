RSpec.describe "Fizzbuzz validator" do
  it "should return nothing if payload is valid" do
    payload = {"int1" => 3, "int2" => 5, "limit" => 15, "str1" => "fizz", "str2" => "buzz"}

    expect(FizzbuzzValidator.validate(payload)).to eq(nil)
  end

  it "should return a message if payload is missing keys" do
    payload = {"int2" => 5, "limit" => 15, "str1" => "fizz", "str2" => "buzz"}
    expected_return = "Missing keys int1"

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)

    payload = {"int1" => 3, "int2" => 5, "str2" => "buzz"}
    expected_return = "Missing keys limit, str1"

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)

    payload = {}
    expected_return = "Missing keys int1, int2, limit, str1, str2"

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
  end

  it "should return a message if any integer value is less than 1" do
    payload = {"int1" => 0, "int2" => 5, "limit" => 15, "str1" => "fizz", "str2" => "buzz"}
    expected_return = "Integers must be 1 or greater"

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
    
    payload = {"int1" => 35, "int2" => -7, "limit" => 15, "str1" => "fizz", "str2" => "buzz"}

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
    
    payload = {"int1" => 0, "int2" => 5, "limit" => -45, "str1" => "fizz", "str2" => "buzz"}

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
    
    payload = {"int1" => 0, "int2" => 0, "limit" => 0, "str1" => "fizz", "str2" => "buzz"}

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
  end

  it "should return a message if any integer value is greater than 1000000" do
    payload = {"int1" => 1000001, "int2" => 5, "limit" => 15, "str1" => "fizz", "str2" => "buzz"}
    expected_return = "Integers must be 1000000 or smaller"

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
    
    payload = {"int1" => 35, "int2" => 65438679384, "limit" => 15, "str1" => "fizz", "str2" => "buzz"}

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
    
    payload = {"int1" => 2, "int2" => 5, "limit" => 131313131313, "str1" => "fizz", "str2" => "buzz"}

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
    
    payload = {"int1" => 987654321, "int2" => 987654321, "limit" => 987654321, "str1" => "fizz", "str2" => "buzz"}

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
  end
  
  it "should return a message if any string is empty" do
    payload = {"int1" => 3, "int2" => 5, "limit" => 15, "str1" => "", "str2" => "buzz"}
    expected_return = "Strings must not be empty"

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
    
    payload = {"int1" => 3, "int2" => 5, "limit" => 15, "str1" => "fizz", "str2" => ""}

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
    
    payload = {"int1" => 3, "int2" => 5, "limit" => 15, "str1" => "", "str2" => ""}

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
  end
  
  it "should return a message if any string is too long" do
    very_long_string = ""
    50.times do
      very_long_string += "very "
    end
    very_long_string += "long string"

    payload = {"int1" => 3, "int2" => 5, "limit" => 15, "str1" => very_long_string, "str2" => "buzz"}
    expected_return = "Strings must be maximum 100 characters long"

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
    
    payload = {"int1" => 3, "int2" => 5, "limit" => 15, "str1" => "fizz", "str2" => very_long_string}

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
    
    payload = {"int1" => 3, "int2" => 5, "limit" => 15, "str1" => very_long_string, "str2" => very_long_string}

    expect(FizzbuzzValidator.validate(payload)).to eq(expected_return)
  end
end
