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
include ApplicationHelper
include EmailHelper

class WelcomeController < ApplicationController
  skip_before_action :check_user_status
  def authenticate
    user = User.find_by("lower(nickname) = ?", remove_whitespace(params[:nickname]).downcase())
    respond_to do |format|
      if user && user.password == witesy_digest(user.salt, params[:password])
        session[:user_id] = user.id
        format.html {
          redirect_to :action=>"index", :controller=>"orders"
        }
        format.json { render :show, status: :ok, location: user }
      else
        format.html {
          flash[:danger] = "Incorrect Email or Password!"
          redirect_to :action=>"index", :controller=>"welcome"
        }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  def logout
    session[:user_id] = nil
    $current_user = nil
    flash[:success] = "You logged out!"
    redirect_to :action=>"index", :controller=>"welcome"
  end

  def confirm_email
     confirm_registration_email(params[:token])
     redirect_to :action=>"index", :controller=>"welcome"
  end
end
