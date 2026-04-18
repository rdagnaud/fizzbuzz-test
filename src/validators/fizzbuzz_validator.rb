class FizzbuzzValidator

=begin
    validate_fizzbuzz checks if the payload parameters are valid
    It returns two values, a boolean indicating if the payload is valid or not
    If it is not, a string detailing the error, otherwise nil
=end
    def self.validate_fizzbuzz(payload)
        required_keys = %i[int1 int2 limit str1 str2]

        missing_keys = required_keys - payload.keys

        return [false, "Missing keys #{missing_keys.join(', ')}"] if missing_keys.any?

        return [false, "Integers must be 1 or greater"] if payload[:int1].to_i < 1 || payload[:int2].to_i < 1 || payload[:limit].to_i < 1

        # Putting an arbitrary maximum value for the 'limit' parameter (to avoid excessive process time and response size)
        return [false, "Limit must be 1000000 or smaller"] if payload[limit].to_i > 1000000

        [true, nil]
    end
end
