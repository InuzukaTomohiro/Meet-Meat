class CreateUserAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :user_achievements do |t|

      t.integer :user_id,        null: false
      t.integer :achievement_id, null: false
      t.timestamps
    end
  end
end
