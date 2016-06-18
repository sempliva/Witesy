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

describe ShippingModesController, :type => :controller do
  describe "GET #index" do
    it "populates an array of shipping mode" do
      login()
      shipping_mode = FactoryGirl.create(:shipping_mode)
      get :index
      expect(assigns(:shipping_modes)).to eq([shipping_mode])
    end
    it "renders the :index view" do
      login()
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested shipping mode to @shipping_mode" do
      login()
      shipping_mode = FactoryGirl.create(:shipping_mode, :mode => "a")
      get :show, id: shipping_mode.id
      expect(assigns(:shipping_mode)).to eq(shipping_mode)
    end
    it "renders the :show template" do
      login()
      shipping_mode = FactoryGirl.create(:shipping_mode, :mode => "b")
      get :show, id: shipping_mode.id
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
        it 'creates the shipping mode' do
          login()
          shipping_mode_params = FactoryGirl.build(:shipping_mode, :mode => "c").attributes
          expect { post :create, :shipping_mode => shipping_mode_params }.to change(ShippingMode,:count).by(1)
        end
        it 'redirects to the "show" action for the new shipping mode' do
          login()
          shipping_mode_params = FactoryGirl.build(:shipping_mode, :mode => "d").attributes
          post :create, shipping_mode: shipping_mode_params
          expect(response).to redirect_to ShippingMode.last
        end
      end

      context 'with invalid attributes' do
        it 'does not create the shipping mode' do
          login()
          shipping_mode_params = FactoryGirl.build(:shipping_mode, :mode => nil).attributes
          expect{
              post :create, shipping_mode: shipping_mode_params
          }.to change(ShippingMode,:count).by(0)
        end
        it 're-renders the "new" view' do
          login()
          shipping_mode_params = FactoryGirl.build(:shipping_mode, :mode => nil).attributes
          post :create, shipping_mode: shipping_mode_params
          expect(response).to render_template :new
        end
      end
    end
end
