class CreateRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :requests do |t|
      t.integer :fizz_value, null: false
      t.integer :buzz_value, null: false
      t.integer :limit, null: false
      t.string :fizz_string, null: false
      t.string :buzz_string, null: false
      t.timestamps
    end

    add_check_constraint :requests, "fizz_value > 0 AND fizz_value <= 1000000", name: "check_fizz_value_range"
    add_check_constraint :requests, "buzz_value > 0 AND buzz_value <= 1000000", name: "check_buzz_value_range"
    add_check_constraint :requests, "limit > 0 AND limit <= 1000000", name: "check_limit_range"
  end
end
