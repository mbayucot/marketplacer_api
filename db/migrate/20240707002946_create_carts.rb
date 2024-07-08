class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.decimal :subtotal, default: 0.0, null: false
      t.decimal :total, default: 0.0, null: false
      t.decimal :discount, default: 0.0, null: false
      t.integer :items_count, default: 0, null: false
      t.references :user, null: false, foreign_key: true
      t.references :promotion, null: true, foreign_key: true

      t.timestamps
    end
  end
end
