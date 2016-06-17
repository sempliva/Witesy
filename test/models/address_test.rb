
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

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "should save address without contry" do
    customer = Customer.new(:name => "test", :label => "test")
    address = Address.new(:city=> "Santa Clara", :street=> "100 Hundred", :zip => "100", :state => "ca")
    customer.addresses = [address]
    assert address.save, "Saved address"
  end

  test "should save address" do
    customer = Customer.new(:name => "test", :label => "test")
    address = Address.new(:city=> "Santa Clara", :street=> "100 Hundred", :zip => "100", :state => "ca", :country => "usa")
    customer.addresses = [address]
    assert address.save, "Saved address"
  end

  test "should save and strip address with spaces" do
    customer = Customer.new(:name => "test", :label => "test")
    address = Address.new(:city=> "Santa Clara", :street=> "       100 Hundred       ", :zip => "100", :state => "ca")
    customer.addresses = [address]
    assert address.save, "Saved the address without city"
  end

  # Tests for "validates" attributes
  test "should not save address with state longer than 2" do
    address = Address.new(:city=> "Santa Clara", :street=> "100 Hundred", :zip => "100", :state => "caaaaa")
    assert  !address.save, "Saved the address with state longer than 2"
  end

  test "should not save address without city" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :state => "ca")
    assert !address.save, "Saved the address without city"
  end

  test "should not save address without street" do
    address = Address.new(:city=> "Santa Clara", :zip => "100", :state => "CA")
    assert !address.save, "Saved the address without street"
  end

  test "should not save address without zip" do
    address = Address.new(:street=> "100 Hundred", :city => "Santa Clara", :state => "CA")
    assert !address.save, "Saved the address without zip"
  end

  test "should not save address without state" do
    address = Address.new(:street=> "100 Hundred", :zip => "100", :city => "Santa Clara")
    assert !address.save, "Saved the address without state"
  end
end
