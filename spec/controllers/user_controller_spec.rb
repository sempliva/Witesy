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

describe UsersController, :type => :controller do
  describe "GET #index" do
    it "populates an array of users" do
      login()
      user = FactoryGirl.create(:user, :user_one)
      get :index
      expect(assigns(:users)).to eq([user])
    end
    it "renders the :index view" do
      login()
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested user to @user" do
      login()
      user = FactoryGirl.create(:user, :user_two)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
    it "renders the :show template" do
      login()
      user = FactoryGirl.create(:user, :user_two)
      get :show, id: user.id
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
        it 'creates the user' do
          login()
          user_params = FactoryGirl.build(:user, :user_three).attributes
          expect { post :create, :user => user_params }.to change(User,:count).by(1)
        end
        xit 'redirects to the "show" action for the new user' do
          login()
          user_params = FactoryGirl.build(:user, :user_three).attributes
          post :create, user: user_params
          expect(response).to redirect_to User.last
        end
      end

      context 'with invalid attributes' do
        it 'does not create the user' do
          login()
          user_params = FactoryGirl.build(:user, :user_one, :nickname => nil).attributes
          expect{
              post :create, user: user_params
          }.to change(User,:count).by(0)
        end
        it 'does not create the user with spaces in nickname' do
          login()
          user_params = FactoryGirl.build(:user, :user_one, :nickname => "with spaces ").attributes
          expect{
              post :create, user: user_params
          }.to change(User,:count).by(0)
        end
        it 're-renders the "new" view' do
          login()
          user_params = FactoryGirl.build(:user, :user_one, :nickname => nil).attributes
          post :create, user: user_params
          expect(response).to render_template :new
        end
      end
    end
end
