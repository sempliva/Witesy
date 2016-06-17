=begin
Copyright (C) 2016 Witesy Contributors

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
=end
require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # Tests for "validates" attributes
  test "should not save customer without address" do
    customer = Customer.new(:name => "customer name", :label => "a")
    assert !customer.save, "Saved the customer without address."
  end

  test "should not save customer without name and label" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer = Customer.new()
    customer.addresses <<  address
    assert !customer.save, "Saved the customer without name and label."
  end

  test "should not save customer without label" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer = Customer.new(:name => "company")
    customer.addresses <<  address
    assert !customer.save, "Saved the customer without label."
  end

  test "should not save two customer with the same name" do
    address = Address.new(:contact_name => "1", :street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer1 = Customer.new(:name => "samename", :label => "samename")
    customer1.addresses << address
    customer1.save
    customer2 = Customer.new(:name => "samename", :label => "samename")
    customer2.addresses << address

    customer2.save
    assert_equal(1, Customer.where("name = 'samename'").count)
  end

  test "should not save two customer with the same label" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer1 = Customer.new(:name => "samelabel", :label => "samelabel")
    customer1.addresses <<  address
    customer2 = Customer.new(:name => "samelabel", :label => "samelabel")
    customer2.addresses <<  address
    customer1.save
    customer2.save
    assert_equal(1, Customer.where("label = 'samelabel'").count)
  end

  test "should not save customer wrong label format" do
    customer = Customer.new(:name => "labelformat", :label => "_C_")
    assert !customer.save, "Saved the customer with wrong label format."
  end

  # Tests relationship using fixture
  fixtures :addresses, :customers, :orders

  def setup
    @billing_address = addresses(:one)
    @customer = customers(:customer_one)
    @order_one = orders(:order_one)
    @order_two = orders(:order_two)
  end

  def test_relationships
    # has_and_belongs_to_many :address
    assert_equal(@customer.addresses.last.id, @billing_address.id)
    assert_equal("street", @customer.addresses.last.street)

    # has_many :orders
    assert_equal(2, @customer.orders.count)
    assert_equal(@order_one.customer_id, @customer.id)
    assert_equal(@order_two.customer_id, @customer.id)
    assert_equal([@customer.id]*2, @customer.orders.collect {|o| o.customer_id })
    #assert_equal(1234, @customer.orders.sort_by {|o| o.id }.first.customer_po)
  end

  test "should save customer" do
    assert @customer.save, "Saved customer"
  end
end
