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

class ShippingModesController < ApplicationController
  before_action :check_user_status
  before_action :set_shipping_mode, only: [:show, :edit, :update]
  def index
    @shipping_modes = ShippingMode.all
    authorize ShippingMode
  end

  def new
    @shipping_mode = ShippingMode.new
    authorize @shipping_mode
  end

  def create
    @shipping_mode = ShippingMode.new(shipping_mode_params)
    authorize @shipping_mode
      if @shipping_mode.save
        flash[:success] = "Shipping Mode created!"
        redirect_to @shipping_mode
      else
        render action: 'new'
      end
  end

  def update
    if @shipping_mode.update(shipping_mode_params)
      flash[:success] = "Shipping Mode updated!"
      redirect_to @shipping_mode
    else
      render action: 'edit'
    end
  end

private
  def set_shipping_mode
    @shipping_mode = ShippingMode.find(params[:id])
    authorize @shipping_mode
  end

  def shipping_mode_params
    params.require(:shipping_mode).permit(:mode)
  end
end
