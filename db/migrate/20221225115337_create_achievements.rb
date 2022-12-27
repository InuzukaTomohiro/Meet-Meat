class CreateAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :achievements do |t|

      t.integer :meat_id,      null: false
      t.string  :title,        null: false
      t.string  :introduction, null: false
      t.integer :condition,    null: false
      t.timestamps
    end
  end
end
