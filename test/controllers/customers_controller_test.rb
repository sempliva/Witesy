=begin
Copyright (C) 2014  Witesy Contributors

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
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      @customer = Customer.new(:name => "customerSave", :label => "Csave")
      post :create, customer: { created_at: @customer.created_at, label: @customer.label, name: @customer.name, updated_at: @customer.updated_at }
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should show customer" do
    @customer = Customer.new(:name => "CustomerShow", :label => "Cshow")
    @customer.save
    get :show, id: @customer.id
    assert_response :success
  end

  test "should get edit" do
    @customer = Customer.new(:name => "CustomerEdit", :label => "Cedit")
    @customer.save
    get :edit, id: @customer.id
    assert_response :success
  end

  test "should update customer" do
    @customer = Customer.new(:name => "CustomerUpdate", :label => "Cupdate")
    @customer.save
    patch :update, id: @customer, customer: { created_at: @customer.created_at, label: @customer.label, name: @customer.name, updated_at: @customer.updated_at }
    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should destroy customer" do
    @customer = Customer.new(:name => "CustomerDestroy", :label => "Cdestroy")
    @customer.save
    assert_difference('Customer.count', -1) do
      delete :destroy, id: @customer.id
    end

    assert_redirected_to "/customers/"
  end
end
