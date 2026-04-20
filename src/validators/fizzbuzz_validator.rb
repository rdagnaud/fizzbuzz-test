class FizzbuzzValidator

=begin
  validate_fizzbuzz checks if the payload parameters are valid
=end
  def self.validate_fizzbuzz(payload)
    required_keys = [:int1, :int2, :limit, :str1, :str2]

    missing_keys = required_keys - payload.keys

    halt 400, "Missing keys #{missing_keys.join(', ')}" if missing_keys.any?

    integer_parameters = payload.values_at(:int1, :int2, :limit)

    # As fizzbuzz logic starts at 1, limit should be 1 or greater
    halt 400, "Integers must be 1 or greater" if integer_parameters.any?{ |n| n.to_i < 1 }

    # Adding an arbitrary upper limit for the integers parameters (to avoid excessive process time and response size in limit case,
    # and to add a boundary in int1 and int2 cases)
    halt 400, "Integers must be 1000000 or smaller" if integer_parameters.any?{ |n| n.to_i > 1000000 }

    string_parameters = payload.values_at(:str1, :str2)

    halt 400, "Strings must not be empty" if string_parameters.any?{ |s| s.empty? }

    # Adding an arbitrary upper limit to string size
    halt 400, "Strings must be maximum 100 characters long" if string_parameters.any?{ |s| s.length > 100 }
  end
end
