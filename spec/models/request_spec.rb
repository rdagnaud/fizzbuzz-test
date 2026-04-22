RSpec.describe "Request model" do
  it "should create a request with valid values" do
    request = Request.create(int1: 2, int2: 10, limit: 25, str1: "even", str2: "tens", hits: 3)

    expect(request.valid?).to eq(true)
    expect{ request.save! }.not_to raise_error
  end

  it "should not validate with int1, int2 or limit equal to 0" do
    request = Request.create(int1: 0, int2: 0, limit: 0, str1: "even", str2: "tens", hits: 3)

    expect(request).not_to be_valid

    request.valid?

    expect(request.errors[:int1]).to include("must be greater than 0")
    expect(request.errors[:int2]).to include("must be greater than 0")
    expect(request.errors[:limit]).to include("must be greater than 0")
  end

  it "should not validate with int1, int2 or limit greater than 1000000" do
    request = Request.create(int1: 20000000, int2: 20000000, limit: 20000000, str1: "even", str2: "tens", hits: 3)

    expect(request).not_to be_valid

    request.valid?

    expect(request.errors[:int1]).to include("must be less than or equal to 1000000")
    expect(request.errors[:int2]).to include("must be less than or equal to 1000000")
    expect(request.errors[:limit]).to include("must be less than or equal to 1000000")
  end

  it "should not validate when int1, int2 or limit are negative" do
    request = Request.create(int1: -13, int2: -15, limit: -19, str1: "even", str2: "tens", hits: 3)

    expect(request).not_to be_valid

    request.valid?

    expect(request.errors[:int1]).to include("must be greater than 0")
    expect(request.errors[:int2]).to include("must be greater than 0")
    expect(request.errors[:limit]).to include("must be greater than 0")
  end

  it "should not validate when int1, int2 or limit are nil" do
    request = Request.create(int1: nil, int2: nil, limit: nil, str1: "even", str2: "tens", hits: 3)

    expect(request).not_to be_valid

    request.valid?

    expect(request.errors[:int1]).to include("can't be blank")
    expect(request.errors[:int2]).to include("can't be blank")
    expect(request.errors[:limit]).to include("can't be blank")
  end

  it "should not validate when int1, int2 or limit are not a number" do
    request = Request.create(int1: "not a number", int2: true, limit: nil, str1: "even", str2: "tens", hits: 3)

    expect(request).not_to be_valid

    request.valid?

    expect(request.errors[:int1]).to include("is not a number")
    expect(request.errors[:int2]).to include("is not a number")
    expect(request.errors[:limit]).to include("is not a number")
  end

  it "should not validate when str1 or str2 are empty" do
    request = Request.create(int1: 2, int2: 10, limit: 25, str1: "", str2: "", hits: 3)

    expect(request).not_to be_valid

    request.valid?

    expect(request.errors[:str1]).to include("can't be blank")
    expect(request.errors[:str2]).to include("can't be blank")
  end

  it "should not validate when str1 or str2 are nil" do
    request = Request.create(int1: 2, int2: 10, limit: 25, str1: nil, str2: nil, hits: 3)

    expect(request).not_to be_valid

    request.valid?

    expect(request.errors[:str1]).to include("can't be blank")
    expect(request.errors[:str2]).to include("can't be blank")
  end

  it "should not validate when str1 or str2 are too long" do
    very_long_string = ""
    50.times do
      very_long_string += "very "
    end
    very_long_string += "long string"

    request = Request.create(int1: 2, int2: 10, limit: 25, str1: very_long_string, str2: very_long_string, hits: 3)

    expect(request).not_to be_valid

    request.valid?

    expect(request.errors[:str1]).to include("is too long (maximum is 100 characters)")
    expect(request.errors[:str2]).to include("is too long (maximum is 100 characters)")
  end

  it "should not validate when hits is missing" do
    request = Request.create(int1: 2, int2: 10, limit: 25, str1: "even", str2: "tens")

    expect(request.valid?).to eq(false)

    expect(request.errors[:hits]).to include("can't be blank")
  end

  it "should not validate when hits is negative" do
    request = Request.create(int1: 2, int2: 10, limit: 25, str1: "even", str2: "tens", hits: -1)

    expect(request.valid?).to eq(false)

    expect(request.errors[:hits]).to include("must be greater than 0")
  end

  it "should not validate when hits is equal to 0" do
    request = Request.create(int1: 2, int2: 10, limit: 25, str1: "even", str2: "tens", hits: 0)

    expect(request.valid?).to eq(false)

    expect(request.errors[:hits]).to include("must be greater than 0")
  end
end
