class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :quantity, null: false
    end

    add_index :order_items, [:order_id, :item_id], unique: true
  end
end
