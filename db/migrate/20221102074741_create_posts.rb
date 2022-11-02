class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id,    null: false
      t.integer :meat_id,    null: false
      t.string  :body,       null: false
      t.integer :sub_weight, null: false
      t.timestamps
    end
  end
end
