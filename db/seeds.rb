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
require 'securerandom'

shipping_modes = ["UPS RED", "UPS Blue", "UPS Ground", "Customer pickup", "FedEx", "Hand delivery"]
shipping_modes.each do |mode|
  ShippingMode.find_or_create_by(mode: mode)
end

role_admin = Role.create(name: "admin")
role_user = Role.create(name: "user")
user = User.new(:nickname => "admin1", :email => "admin@admin.com", :password => "password", :confirmed_email => true)
user.save

assignments = Assignment.create(:role => role_admin, :user => user)
