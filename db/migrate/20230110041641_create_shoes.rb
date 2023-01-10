class CreateShoes < ActiveRecord::Migration[7.0]
  def change
    create_table :shoes do |t|
      t.references :store, null: false, foreign_key: true
      t.string :model, null: false
      t.integer :inventory, default: 0
      t.integer :alert, default: 1

      t.timestamps
    end
  end
end
