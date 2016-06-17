require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # Test for "validates" attributes and relationships
  test "should not save order without customer" do
    address = Address.new( :street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    order = Order.new(:order_number => "1", :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today() , :ship_by => Date.tomorrow())
    order.shipping_address = address
    order.billing_address = address
    assert !order.save, "Saved the order without customer"
  end

  test "should not save order without shipping address" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer = Customer.new(:name => "customer name", :label => "a" )
    order = Order.new(:customer=> customer, :order_number => "1", :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today()  )
    order.shipping_address = address
    assert !order.save, "Saved the order without shipping address"
  end

  test "should not save order without billing address" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer = Customer.new(:label => "b", :name => "customer name" )
    order = Order.new(:customer=> customer, :order_number => "1", :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today()  )
    order.billing_address = address
    assert !order.save, "Saved the order without billing address"
  end

  test "should not save order without ship_by" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer = Customer.new(:name => "customer name", :label => "c")
    order = Order.new(:customer => customer, :order_number => "1", :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today())
    order.shipping_address = address
    order.billing_address = address
    assert !order.save, "Saved the order without ship_by"
  end

  # Tests relationship using fixture
  fixtures :addresses, :customers, :orders, :items

  def setup
    @shipping_address = addresses(:one)
    @billing_address = addresses(:two)
    @customer = customers(:customer_one)
    @order_one = orders(:order_one)
    @order_two = orders(:order_two)
    @item_one = items(:item_one)
  end

  def test_relationships
    # belongs_to :address
    assert_equal(@order_one.shipping_address.id, @shipping_address.id)
    assert_equal(@order_one.billing_address.id, @billing_address.id)
    assert_equal("street", @order_one.shipping_address.street)

    # belongs_to :customer
    assert_equal(@order_one.customer_id, @customer.id)
    assert_equal("Company name", @order_one.customer.name)
    assert_equal(@order_two.customer_id, @customer.id)
    assert_equal("Company name", @order_two.customer.name)

    # has_many :analyses
    assert_equal(1, @order_one.items.count)
    assert_equal([@order_one.id]*1, @order_one.items.collect {|o| o.order_id })
  end

  test "should save order" do
    assert @order_one.save, "Saved order"
  end

  test "should not save two order with the same order number" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer = Customer.new(:name => "customer name", :label => "d")
    order1 = Order.new(:customer => customer, :order_number => "1", :ship_by => Date.tomorrow, :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today())
    order2 = Order.new(:customer => customer, :order_number => "1", :ship_by => Date.tomorrow, :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today())
    order1.shipping_address = address
    order1.billing_address = address
    order2.shipping_address = address
    order2.billing_address = address
    order1.save
    order2.save
    assert_equal(1, Order.where("order_number = '1'").count)
  end
end
