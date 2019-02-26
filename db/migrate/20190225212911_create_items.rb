class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.integer :category, null: false
      t.integer :color, null: false
      t.integer :price, null: false
      t.integer :quantity, null: false, default: 0
      t.timestamps
    end
  end
end
