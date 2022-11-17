class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|

      t.integer :user_id,      null: false
      t.integer :meat_id,      null: false
      t.string  :body,         null: false
      t.integer :once_weight,  null: false
      t.boolean :on_display,   null: false, default: true
      t.boolean :is_active,    null: false, default: true
      t.timestamps
    end
  end
end
