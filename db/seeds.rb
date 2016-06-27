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

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'open-uri'

shipping_modes = ["UPS RED", "UPS Blue", "UPS Ground", "Customer pickup", "FedEx", "Hand delivery"]
shipping_modes.each do |mode|
  ShippingMode.find_or_create_by(mode: mode)
end

# Remove comments to enable order seeds
#address = Address.create(:street=> "100 Hundred", :zip => "100", :state => "CA", :city => "San Francisco")
#customer = Customer.create(:name => "ACME Electronics", :address => address)
#order = Order.create(:customer => customer, :address => address, :ship_by => Date.today(), :sales_order_number => "1", :customer_po => "1235", :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today())
#analysis = Analysis.create(:order => order, :analysis_number => "1", :lot_date_code => "201212", :quantity => 3, :price => 300 , :component_id=> 1)
#line_item = LineItem.create(:analysis => analysis, :type_analysis_id => 1, :specification_id => 1)
#serial = Serial.create(:serial => "1234567", :component_id => 1, :line_item => line_item)

#order = Order.create(:customer => customer, :address => address, :ship_by => Date.today(), :sales_order_number => "2", :customer_po => "12", :shipping_mode => "UPS", :payment_term => "30 days", :order_date => Date.today())
#analysis = Analysis.create(:order => order, :analysis_number => "2", :lot_date_code => "201212", :quantity => 3, :price => 300 , :component_id=> 2)
#line_item = LineItem.create(:analysis => analysis, :type_analysis_id => 1, :specification_id => 1)
#serial = Serial.create(:serial => "234567890", :component_id => 2, :line_item => line_item)
# End order seeds
