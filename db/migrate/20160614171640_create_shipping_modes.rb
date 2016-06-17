class CreateShippingModes < ActiveRecord::Migration
  def change
    create_table :shipping_modes do |t|
      t.string :mode

      t.timestamps
    end
    add_index :shipping_modes, :mode, unique: true
  end
end
