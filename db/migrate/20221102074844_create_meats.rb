class CreateMeats < ActiveRecord::Migration[6.1]
  def change
    create_table :meats do |t|

      t.timestamps
    end
  end
end
