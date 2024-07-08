class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.decimal :threshold, null: false, default: 0
      t.decimal :discount, null: false, default: 0

      t.timestamps
    end
  end
end
