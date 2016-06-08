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

require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "should save customer" do
    customer = Customer.new(:name => "test", :label => "test")
    assert customer.save, "Saved customer."
  end

  # Tests for "validates" attributes
  test "should not save customer without name" do
    customer = Customer.new(:label => "CN")
    assert !customer.save, "Saved the customer without name."
  end

  test "should not save customer without label" do
    customer = Customer.new(:name => "company")
    assert !customer.save, "Saved the customer without label."
  end

  test "should not save two customer with the same name" do
    customer1 = Customer.new(:name => "samename", :label => "CN")
    customer2 = Customer.new(:name => "samename", :label => "CN2")
    customer1.save
    customer2.save
    assert_equal(1, Customer.where(:name => "samename").count)
  end

  test "should not save two customer with the same label" do
    customer1 = Customer.new(:name => "samelabel", :label => "samelabel")
    customer2 = Customer.new(:name => "samelabel", :label => "samelabel")
    customer1.save
    customer2.save
    assert_equal(1, Customer.where(:label => "samelabel").count)
  end

  test "should not save customer wrong label format" do
    customer = Customer.new(:name => "company", :label => "_C_")
    assert !customer.save, "Saved the customer with wrong label format."
  end
end
