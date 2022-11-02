class CreateUserMeats < ActiveRecord::Migration[6.1]
  def change
    create_table :user_meats do |t|

      t.timestamps
    end
  end
end
