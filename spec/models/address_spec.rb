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

RSpec.describe Address, :type => :model do
  describe "validations" do
    it "has a valid factory" do
      FactoryGirl.build(:address)
    end
    it "is invalid without state" do
      expect(FactoryGirl.build(:address, state: nil)).not_to be_valid
    end
    it "is invalid without city" do
      expect(FactoryGirl.build(:address, city: nil)).not_to be_valid
    end
    it "is invalid without street" do
      expect(FactoryGirl.build(:address, street: nil)).not_to be_valid
    end
    it "is invalid without zip" do
      expect(FactoryGirl.build(:address, zip: nil)).not_to be_valid
    end
    it "has no spaces in the street" do
      address = FactoryGirl.create(:address, contact_name: "   Contact    ")
      expect(address.contact_name).to eq "Contact"
    end
    it "is invalid with a state longer than 2" do
      expect(FactoryGirl.build(:address, state: "abc")).not_to be_valid
    end
  end
end
