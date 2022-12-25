class CreateAchievements < ActiveRecord::Migration[6.1]
  def change
    create_table :achievements do |t|

      t.string  :title,  null: false
      t.boolean :is_get, null: false, default: :false
      t.timestamps
    end
  end
end
