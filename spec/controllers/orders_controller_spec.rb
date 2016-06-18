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

require 'rails_helper'

describe OrdersController, :type => :controller do
  describe "GET #index" do
    it "populates an array of orders" do
      login()
      item = FactoryGirl.build(:item)
      customer = FactoryGirl.build(:customer, :customer_one)
      shipping_address = FactoryGirl.build(:address)
      billing_address = FactoryGirl.build(:address)
      order = FactoryGirl.create(:order, :items => [item], :customer => customer, :shipping_address => shipping_address, :billing_address => billing_address)
      get :index
      expect(assigns(:orders)).to eq([order])
    end
    it "renders the :index view" do
      login()
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested order to @order" do
      login()
      item = FactoryGirl.build(:item)
      customer = FactoryGirl.build(:customer, :customer_one)
      shipping_address = FactoryGirl.build(:address)
      billing_address = FactoryGirl.build(:address)
      order = FactoryGirl.create(:order, :items => [item], :customer => customer, :shipping_address => shipping_address, :billing_address => billing_address)
      get :show, id: order.id
      expect(assigns(:order)).to eq(order)
    end
    it "renders the :show template" do
      login()
      item = FactoryGirl.build(:item)
      customer = FactoryGirl.build(:customer, :customer_one)
      shipping_address = FactoryGirl.build(:address)
      billing_address = FactoryGirl.build(:address)
      order = FactoryGirl.create(:order, :items => [item], :customer => customer, :shipping_address => shipping_address, :billing_address => billing_address)

      get :show, id: order.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "renders the :new template" do
      login()
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
      context 'with valid attributes' do
        it 'creates the order' do
          login()
          address_params = FactoryGirl.build(:address).attributes
          customer_params = FactoryGirl.build(:customer, :customer_three).attributes
          customer_params[:addresses_attributes] = address_params
          items_params = FactoryGirl.build(:item).attributes
          order_params = FactoryGirl.build(:order).attributes
          order_params[:customer_attributes] = customer_params
          order_params[:billing_address_attributes] = address_params
          order_params[:shipping_address_attributes] = address_params
          order_params[:items_attributes] = {"0"=> items_params}

          expect { post :create, :order => order_params }.to change(Order,:count).by(1)
        end
        it 'redirects to the "show" action for the new customer' do
          login()
          address_params = FactoryGirl.build(:address).attributes
          customer_params = FactoryGirl.build(:customer, :customer_three).attributes
          customer_params[:addresses_attributes] = address_params
          items_params = FactoryGirl.build(:item).attributes
          order_params = FactoryGirl.build(:order).attributes
          order_params[:customer_attributes] = customer_params
          order_params[:billing_address_attributes] = address_params
          order_params[:shipping_address_attributes] = address_params
          order_params[:items_attributes] = {"0"=> items_params}

          post :create, order: order_params
          expect(response).to redirect_to Order.last
        end
      end

      context 'with invalid attributes' do
        it 'does not create the order' do
          login()
          address_params = FactoryGirl.build(:address).attributes
          customer_params = FactoryGirl.build(:customer, :customer_three).attributes
          customer_params[:addresses_attributes] = address_params
          items_params = FactoryGirl.build(:item).attributes
          order_params = FactoryGirl.build(:order).attributes
          order_params[:customer_attributes] = customer_params

          order_params[:billing_address_attributes] = {}

          order_params[:shipping_address_attributes] = address_params
          order_params[:items_attributes] = {"0"=> items_params}
          expect{
              post :create, order: order_params
          }.to change(Order,:count).by(0)
        end
        it 're-renders the "new" view' do
          login()
          address_params = FactoryGirl.build(:address).attributes
          customer_params = FactoryGirl.build(:customer, :customer_three).attributes
          customer_params[:addresses_attributes] = address_params
          items_params = FactoryGirl.build(:item).attributes
          order_params = FactoryGirl.build(:order).attributes
          order_params[:customer_attributes] = customer_params

          order_params[:billing_address_attributes] = {}

          order_params[:shipping_address_attributes] = address_params
          order_params[:items_attributes] = {"0"=> items_params}
          post :create, order: order_params
          expect(response).to render_template :new
        end
      end
    end
end
