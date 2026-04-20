class FizzbuzzService
  def self.fizzbuzz(payload)
    fizz_value, buzz_value, limit = payload.values_at(:int1, :int2, :limit).map{ |n| n.to_i }
    fizz_string, buzz_string = payload.values_at(:str1, :str2)
    fizzbuzz_array = []

    Request.create!(
      int1: fizz_value,
      int2: buzz_value,
      limit: limit,
      str1: fizz_string,
      str2: buzz_string
    )

    (1..limit).map do |i|
      string_to_add = ""

      string_to_add += fizz_string if i % fizz_value == 0
      string_to_add += buzz_string if i % buzz_value == 0

      fizzbuzz_array << (string_to_add.empty? ? i.to_s : string_to_add)
    end

    fizzbuzz_array
  end
end
