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

RSpec.describe Customer, :type => :model do

  describe "associations" do
    it "it should have many addresses" do
      expect(Customer.reflect_on_association(:addresses).macro).to eq :has_and_belongs_to_many
    end
  end

  describe "validations" do
    it "has a valid factory" do
      address = FactoryGirl.build(:address)
      FactoryGirl.build(:customer, :addresses => [address])
    end
    it "is invalid without a name" do
      expect(FactoryGirl.build(:customer, name: nil)).not_to be_valid
    end
    it "is invalid without a label" do
      expect(FactoryGirl.build(:customer, label: nil)).not_to be_valid
    end
    it "is invalid with a label length more than 20" do
      expect(FactoryGirl.build(:customer, label: "abcdefghilmnopqrstuvz")).not_to be_valid
    end
    it "has unique name" do
      FactoryGirl.create(:customer, :customer, :name => "name")
      expect { FactoryGirl.create(:customer, :customer, :name => "name")}.to raise_error( ActiveRecord::RecordInvalid)
    end
    it "has unique label" do
      FactoryGirl.create(:customer, :customer, :label => "label")
      expect { FactoryGirl.create(:customer, :customer, :label => "label") }.to raise_error( ActiveRecord::RecordInvalid)
    end

  end
end
