class CreateUserMeats < ActiveRecord::Migration[6.1]
  def change
    create_table :user_meats do |t|

      t.integer :user_id,      null: false
      t.integer :daily_weight, null: false, default: 0
      t.timestamps
    end
  end
end
