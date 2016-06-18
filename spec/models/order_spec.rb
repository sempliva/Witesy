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

RSpec.describe Order, :type => :model do
  describe "associations" do
    it "it should have many items" do
      expect(Order.reflect_on_association(:items).macro).to eq :has_many
    end
    it "it should have a customer" do
      expect(Order.reflect_on_association(:customer).macro).to eq :belongs_to
    end
    it "it should have a shipping_address" do
      expect(Order.reflect_on_association(:shipping_address).macro).to eq :belongs_to
    end
    it "it should have a billing_address" do
      expect(Order.reflect_on_association(:billing_address).macro).to eq :belongs_to
    end
  end

  describe "validations" do
    it "has a valid factory" do
      item = FactoryGirl.build(:item)
      customer = FactoryGirl.build(:customer)
      shipping_address = FactoryGirl.build(:address)
      billing_address = FactoryGirl.build(:address)
      FactoryGirl.build(:order, :items => [item], :customer => customer, :shipping_address => shipping_address, :billing_address => billing_address)
    end
    it "is invalid without customer_name" do
      expect(FactoryGirl.build(:order, customer_name: nil)).not_to be_valid
    end
    it "is invalid without order_number" do
      expect(FactoryGirl.build(:order, order_number: nil)).not_to be_valid
    end
    it "is invalid without shipping_mode" do
      expect(FactoryGirl.build(:order, shipping_mode: nil)).not_to be_valid
    end
    it "is invalid without payment_term" do
      expect(FactoryGirl.build(:order, payment_term: nil)).not_to be_valid
    end
    it "is invalid without order_date" do
      expect(FactoryGirl.build(:order, order_date: nil)).not_to be_valid
    end
    it "is invalid without ship_by" do
      expect(FactoryGirl.build(:order, ship_by: nil)).not_to be_valid
    end
    it "has unique order_number" do
      item = FactoryGirl.create(:item, item_number: "2")
      customer = FactoryGirl.create(:customer, :customer)
      shipping_address = FactoryGirl.create(:address)
      billing_address = FactoryGirl.create(:address)
      FactoryGirl.create(:order, :items => [item], :customer => customer, :shipping_address => shipping_address, :billing_address => billing_address)

      expect { FactoryGirl.create(:order, :items => [item], :customer => customer, :shipping_address => shipping_address, :billing_address => billing_address) }.to raise_error( ActiveRecord::RecordInvalid)
    end
    it "has ship by date greater than order date" do
      order = FactoryGirl.build(:order)
      expect(order.ship_by).to be >= order.order_date
    end
  end
end
