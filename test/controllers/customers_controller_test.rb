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

class CustomersControllerTest < ActionController::TestCase

  # Tests controllers's method using fixture
  fixtures :addresses, :customers, :orders

  def setup
    #request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(LittletubeConfiguration::Authentication::USERNAME,LittletubeConfiguration::Authentication::PASSWORD)
    @billing_address = addresses(:one)
    @customer = customers(:customer_one)
    @order_one = orders(:order_one)
    @order_two = orders(:order_two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "should get show" do
    get :show, { :id => @customer.id }
    assert_response :success
    assert_not_nil assigns(:customer)
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post :create, customer: { label: "CP", name: "company",
          addresses_attributes: {"0"=>{contact_name: "Contact Name", street: "street", city: "city", zip: "zip",  state: "CA"},
                               "1"=>{contact_name: "Contact Name1", street: "street1", city: "city1", zip: "zip1",  state: "CA"}}}
    end
    assert_redirected_to customer_path(assigns(:customer))
  end

  def test_routes
    assert_routing "customers/2", { :controller => 'customers', :id => '2', :action => 'show' }
    assert_routing "customers/new", { :controller => 'customers', :action => 'new' }
  end
end
