class CreateDailyEats < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_eats do |t|

      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
