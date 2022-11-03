class CreatePostMeats < ActiveRecord::Migration[6.1]
  def change
    create_table :post_meats do |t|

      t.integer :meat_id, null: false
      t.integer :post_id, null: false
      t.timestamps
    end
  end
end
