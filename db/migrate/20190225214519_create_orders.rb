class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :total, null: false
      t.integer :discount, null: false, default: 0
      t.timestamps
    end
  end
end