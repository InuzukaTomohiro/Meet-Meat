class CreateUserMeats < ActiveRecord::Migration[6.1]
  def change
    create_table :user_meats do |t|

      t.integer :meat_id,      null: false
      t.integer :user_id,      null: false
      t.integer :total_weight, null: false
      t.timestamps
    end
  end
end
