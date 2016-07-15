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
include TokensHelper
include EmailHelper

class UsersController < ApplicationController
  before_action :check_user_status, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    authorize User
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    User.transaction do
    respond_to do |format|
      if @user.save
        format.html {
          token_string = generate_and_save_token(@user.email, @user.id)
          send_email_confirmation(@user.email, token_string)
          flash[:success] = "You're a click a way to be done: check your email in a bit and confirm your registration clicking on the activation link."
          redirect_to :action=>"index", :controller=>"welcome"
        }
        format.json { redirect_to :action=>"index", :controller=>"orders", status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  def update
    respond_to do |format|
      authorize @user
      if @user.update(user_params)
        format.html {
          flash[:success] = 'User was successfully updated.'
          redirect_to @user
        }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit!
    end
end
