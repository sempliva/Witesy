class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :label

      t.timestamps
    end
    add_index :customers, :name, unique: true
  end
end
