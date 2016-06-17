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

class UtilitiesController < ApplicationController
  # * BEGIN - Customer Utility Methods, used while adding a new Order

  # Load customer information based on the customer_name including billing addresses information
  def load_by_customer_name
    customer_name = request.headers["HTTP_CUSTOMER_NAME"]
    @customer = Customer.where("name = ?", customer_name).first
    respond_to do |format|
      format.json { render :json => @customer.to_json() }
    end
  end

  def load_contacts_by_customer_name
    customer_name = request.headers["HTTP_CUSTOMER_NAME"]
    @customer = Customer.includes(:addresses).where("customers.name= ?", customer_name).first
    respond_to do |format|
      format.json { render :json => @customer.addresses.map(&:contact_name).to_json() }
    end
  end


  # Load distinct shipping addresses of a customer based on previous orders shipping addresses
  def load_previous_shipping_addresses_for_customer
    raise 'Customer Id not valid' unless /\d+/=~ params[:id] && params[:id].to_i > 0

    @addresses = Address.select("DISTINCT addresses.contact_name, addresses.street,addresses.city, addresses.state, addresses.zip,addresses.country").joins(:order).where("orders.customer_id= ?", params[:id])
    respond_to do |format|
      format.json { render :json => @addresses.map { |address| {label: address.contact_name, value: address.contact_name } } }
    end
  end

  # Load first address available from addresses based on a specific contact name. Used to populate shipping address fields while adding a new order.
  def load_address_by_contact_name
    contact_name = request.headers["HTTP_CONTACT_NAME"]
    customer_name = request.headers["HTTP_CUSTOMER_NAME"]
    @address = Address.where("contact_name= ?", contact_name).first
    # @address = Customer.where(:name => customer_name).first.addresses.where(:contact_name => contact_name).first
    print(@address)
    respond_to do |format|
      format.json { render :json => @address.to_json }
    end
  end

  # Load last order for a specific customer. Used to populate shipping mode field while adding a new order.
  def get_last_customer_shipping_mode
    customer_name = request.headers["HTTP_CUSTOMER_NAME"]
    @order = Order.joins(:customer).select(:shipping_mode).where("customers.name= ?", customer_name).order(:created_at).last
    #
    # customer_id = Customer.where(name: customer_name).pluck(:id)
    # @order = Order.only(:shipping_mode).where(:customer => customer_id).order_by(created_at: :desc).last
    respond_to do |format|
      format.json { render :json => @order }
    end
  end
  # * END - Customer Utility Methods, used while adding a new Order

  # * BEGIN - Analysis Utility Methods, used while adding a new Order

  # Get next value after removing html tags
  def get_next
    value = view_context.sanitize_user_input(params[:value])
    join_char = "-"
    if value.include?(join_char)
      left, right = value.split(join_char)
      right = right.next!
      value = [left, join_char, right].join
    else
      value.next!
    end
    respond_to do |format|
      format.json { render :json => value.to_json }
    end
  end
  # * END - Analysis Utility Methods, used while adding a new Order

end
