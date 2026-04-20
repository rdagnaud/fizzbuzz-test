class CreateRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :requests do |t|
      t.integer :int1, null: false
      t.integer :int2, null: false
      t.integer :limit, null: false
      t.string :str1, null: false
      t.string :str2, null: false
      t.integer :hits, null: false
      t.timestamps
    end

    add_check_constraint :requests, "int1 > 0 AND int1 <= 1000000", name: "check_int1_validity"
    add_check_constraint :requests, "int2 > 0 AND int2 <= 1000000", name: "check_int2_validity"
    add_check_constraint :requests, "limit > 0 AND limit <= 1000000", name: "check_limit_validity"
  end
end
