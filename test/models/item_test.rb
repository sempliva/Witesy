require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  # Test for "validates" attributes
  test "should not save item without item number" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer = Customer.new(:label => "b", :name => "customer name" )
    order = Order.new(:customer => customer, :order_number => "1", :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today(), :ship_by => Date.today())
    item = Item.new(:order => order, :quantity => 3, :price => 300, :description => "desc")
    assert !item.save, "Saved the item without item number"
  end

  test "should not save item without quantity" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer = Customer.new(:label => "c", :name => "customer name" )
    order = Order.new(:customer => customer, :order_number => "2", :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today(), :ship_by => Date.today())
    item = Item.new(:order => order, :item_number => 2, :price => 300, :description => "desc")
    assert !item.save, "Saved the item without quantity"
  end

  test "should not save item without price" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer = Customer.new(:label => "d", :name => "customer name" )
    order = Order.new(:customer => customer, :order_number => "3", :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today(), :ship_by => Date.today())
    item = Item.new(:order => order, :item_number => 3, :quantity => 300, :description => "desc")
    assert !item.save, "Saved the item without price"
  end

  test "should not save two items with the same item number" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
    customer = Customer.new(:label => "e", :name => "customer name" )
    order = Order.new(:customer => customer, :order_number => "5", :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today(), :ship_by => Date.today())
    item1 = Item.new(:order => order, :item_number => "1234", :quantity => 3, :price => 1)
    item2 = Item.new(:order => order, :item_number => "1234", :quantity => 3, :price => 1)
    item1.save
    item2.save
    assert_equal(1, Item.where("item_number = '1234'").count)
  end

  # Tests relationship using fixture
  fixtures :orders, :items

  def setup
    @order_one = orders(:order_one)
    @order_two = orders(:order_two)
    @item_one = items(:item_one)
    @item_two = items(:item_two)
  end

  def test_relationships
    # belongs_to :order
    assert_equal(@item_one.order_id, @order_one.id)
  end

  test "should save item" do
    assert @item_two.save, "Saved item"
  end
end
