class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_number
      t.integer :quantity
      t.decimal :price
      t.date :shipment_date
      t.string :description
      t.text :note
      t.belongs_to :order

      t.timestamps
    end
    add_index :items, :item_number, unique: true
  end
end
