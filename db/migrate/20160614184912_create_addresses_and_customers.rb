class CreateAddressesAndCustomers < ActiveRecord::Migration
  def change
    create_table :addresses_customers, id: false do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :address, index: true

      t.timestamps
    end
  end
end
