require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  # Tests controllers's method using fixture
  fixtures :addresses, :customers, :orders

  def setup
    #request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(LittletubeConfiguration::Authentication::USERNAME,LittletubeConfiguration::Authentication::PASSWORD)
    @billing_address = addresses(:one)
    @shipping_address = addresses(:two)
    @customer = customers(:customer_one)
    @order_one = orders(:order_one)
    @order_two = orders(:order_two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get show" do
    get :show, { :id => @order_one.id }
    assert_response :success
    assert_not_nil assigns(:order)
  end

  #Create method is actually doing some other stuff that here is not taken in consideration.
  # test "should create order" do
  #   @customer.save
  #
  #   assert_difference('Order.count') do
  #     post :create, order: {customer_attributes: {id: @customer.id},
  #                           billing_address_attributes: {contact_name: "Contact Name", street: "street", city: "city", zip: "zip", state: "CA", country:"USA"},
  #                           shipping_address_attributes: {contact_name: "Contact Name", street: "street", city: "city", zip: "zip", state: "CA"},
  #                           order_number: "1", order_date: "2016-06-01", ship_by: "2016-06-30", shipping_mode: "UPS Blue", payment_term: "NET 30",
  #                           items_attributes: {"0"=>{item_number: "1", description: "test description item", quantity: "1",
  #                                               price: "100", note: ""}
  #                                             }
  #                         }
  #   end
  #   assert_redirected_to order_path(assigns(:order))
  # end

  def test_routes
    assert_routing "orders/2", { :controller => 'orders', :id => '2', :action => 'show' }
    assert_routing "orders/new", { :controller => 'orders', :action => 'new' }
  end
end
