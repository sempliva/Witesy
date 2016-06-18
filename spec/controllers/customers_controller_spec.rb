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

describe CustomersController, :type => :controller do
  describe "GET #index" do
    it "populates an array of customers" do
      login()
      address = FactoryGirl.build(:address)
      customer = FactoryGirl.create(:customer, :customer, :addresses => [address])
      get :index
      expect(assigns(:customers)).to eq([customer])
    end
    it "renders the :index view" do
      login()
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested customer to @customer" do
      login()
      address = FactoryGirl.build(:address)
      customer = FactoryGirl.create(:customer, :customer_one, :addresses => [address])
      get :show, id: customer.id
      expect(assigns(:customer)).to eq(customer)
    end
    it "renders the :show template" do
      login()
      address = FactoryGirl.build(:address)
      customer = FactoryGirl.create(:customer, :customer_two, :addresses => [address])
      get :show, id: customer.id
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
        it 'creates the customer' do
          login()
          address = FactoryGirl.build(:address).attributes
          customer_params = FactoryGirl.build(:customer, :customer_three).attributes
          customer_params[:addresses_attributes] = address
          expect { post :create, :customer => customer_params }.to change(Customer,:count).by(1)
        end
        it 'redirects to the "show" action for the new customer' do
          login()
          address = FactoryGirl.build(:address).attributes
          customer_params = FactoryGirl.build(:customer, :customer_four).attributes
          customer_params[:addresses_attributes] = address
          post :create, customer: customer_params
          expect(response).to redirect_to Customer.last
        end
      end

      context 'with invalid attributes' do
        it 'does not create the customer' do
          login()
          address = FactoryGirl.build(:address)
          customer = FactoryGirl.build(:customer, :customer_five, :label => nil, :addresses => [address]).attributes
          expect{
              post :create, customer: customer
          }.to change(Customer,:count).by(0)
        end
        it 're-renders the "new" view' do
          login()
          address = FactoryGirl.build(:address)
          customer = FactoryGirl.build(:customer, :customer_six, :label => nil, :addresses => [address]).attributes
          post :create, customer: customer
          expect(response).to render_template :new
        end
      end
    end
end
