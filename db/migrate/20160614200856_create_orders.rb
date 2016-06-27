class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_number
      t.string :shipping_mode
      t.string :payment_term
      t.date :order_date
      t.date :ship_by
      t.belongs_to :customer
      t.belongs_to :billing_address
      t.belongs_to :shipping_address

      t.timestamps
    end
    add_index :orders, :order_number, unique: true
  end
end
