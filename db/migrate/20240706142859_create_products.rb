class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :uuid, null: false, unique: true
      t.string :name, null: false
      t.decimal :price, null: false

      t.timestamps
    end
  end
end
