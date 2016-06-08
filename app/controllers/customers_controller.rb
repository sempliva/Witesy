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

class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all.order(label: :asc)
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @customer.addresses.build
  end


  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.create(customer_params)
    if @customer.save
      flash[:success] = "Customer created!"
      redirect_to @customer
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    print(customer_params)
    if @customer.update_attributes(customer_params)
      flash[:success] = "Customer updated!"
      redirect_to @customer
    else
      render action: 'edit'
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    if @customer.delete
      flash[:success] = "Customer has been deleted successfully!"
      redirect_to "/customers/"
    else
      flash[:danger] = "Oops! Something very nasty happened."
      redirect_to "/customers/" + @customer.id.to_s
    end
  end

  private
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit!
    end
end
