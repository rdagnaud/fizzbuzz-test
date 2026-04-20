class Request < ActiveRecord::Base
  validates :fizz_value, :buzz_value, :limit, presence: true,
            numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 1000000 }

  validates :fizz_string, :buzz_string, presence: true, length: { maximum: 100 }


end