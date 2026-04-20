class Request < ActiveRecord::Base
  validates :int1, :int2, :limit, presence: true,
            numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 1000000 }

  validates :str1, :str2, presence: true, length: { maximum: 100 }
end
