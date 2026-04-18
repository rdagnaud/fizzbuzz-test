class FizzbuzzService
    def self.fizzbuzz(payload)
        fizz_value, buzz_value, limit, fizz_string, buzz_string = payload.values_at(:int1, :int2, :limit, :str1, :str2)
        fizzbuzz_array = []

        for i in 1..limit
            string_to_add = ""

            string_to_add.concat(fizz_string) if i % fizz_value == 0

            string_to_add.concat(buzz_string) if i % buzz_value == 0

            fizzbuzz_array.push(string_to_add.empty? ? i.to_s : string_to_add)
        end

        fizzbuzz_array
    end
end
