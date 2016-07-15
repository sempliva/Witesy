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

class OrdersController < ApplicationController
  before_action :check_user_status
  before_action :load_shipping_modes, only: [:new, :create, :edit, :update]
  before_action :set_user, only: [:show, :edit, :destroy]

  def index
    respond_to do |format|
      format.html {
        sorting_param = params[:sort] ? params[:sort] : :order_number
        @orders = Order.includes(:customer).order(sorting_param).page(params[:page]).per(WitesyConfiguration::PAGINATION_PREFERENCE)
        authorize Order
      }
    end
  end

  def new
    @order = Order.new
    authorize @order
    @order.order_number = get_next_sorted(Order.select(:order_number).map(&:order_number))
    @order.payment_term = "NET 30"
    @customer = Customer.new
    @order.customer = @customer
    @billing_address = Address.new
    @order.billing_address = @billing_address
    @shipping_address= Address.new
    @order.shipping_address = @shipping_address
    @items = @order.items.build
    @items.item_number = @order.order_number
  end

  def create
    begin
      Order.transaction do
        @order = Order.new(order_params)
        authorize @order
        # Check if the customer exists and remove it from the params list to prevent it to be saved.
        _customer = Customer.find_by_name(params[:order][:customer_name])

        if _customer
          params[:order].delete(:customer_attributes)
          @order = Order.create(order_params)
          @order.customer_id = _customer.id
        else
          params[:order][:customer_attributes][:addresses_attributes] = {"0"=> params[:order][:billing_address_attributes]}
          @order = Order.create(order_params)
        end

        if @order.save
          flash[:success] = "Order created!"
          redirect_to @order
        else
          render action: 'new'
          raise ActiveRecord::Rollback
        end
      end
        rescue ActiveRecord::RecordNotUnique => error
        render action: 'new'
     end
    end

  def update
    begin
      Order.transaction do
        @order = Order.find(params[:id])
        authorize @order
        if @order.update(order_params)
          flash[:success] = "Order updated!"
          redirect_to @order
        else
          render action: 'edit'
          raise ActiveRecord::Rollback
        end
      end
      rescue ActiveRecord::RecordNotUnique => error
        render action: 'edit'
      end
  end

 def destroy_multiple
    Order.transaction do
      authorize Order
      if Order.where(:id => params[:orders_ids]).destroy_all
        respond_to do |format|
          flash[:success] = "Orders have been deleted successfully!"
          format.js {render :js => "window.location = '/orders'" }
        end
      else
        raise ActiveRecord::Rollback
        respond_to do |format|
          flash[:danger] = "Oops! Something very nasty happened." + error
          format.js {render :js => "window.location = '/orders'" }
        end
      end
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = "Order has been deleted successfully!"
      redirect_to "/orders/"
    else
      flash[:danger] = "Oops! Something very nasty happened."
      redirect_to "/orders/" + @order.id.to_s
    end
  end

private
  def set_user
    @order = Order.find(params[:id])
    authorize @order
  end

  def load_shipping_modes
    @existing_shipping_modes = ShippingMode.all.collect { |p| [p.mode, p.mode] }
  end

  def order_params
    params.require(:order).permit!
  end

  # Sort an alphanumeric array and get next
  def get_next_sorted(alphanumeric_array)
    if alphanumeric_array.length >= 1
      sorted = alphanumeric_array.sort_by do |id|
        id.scan(/\d+|[a-zA-Z]+/).map { |c| c =~ /\d/ ? c.rjust(255) : c.ljust(255) }.join
      end
      sorted.last.next
    end
  end
end
