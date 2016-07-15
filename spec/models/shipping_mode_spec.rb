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

RSpec.describe ShippingMode, :type => :model do
  describe "validations" do
    it "has a valid factory" do
      FactoryGirl.build(:shipping_mode)
    end
    it "is invalid without mode" do
      expect(FactoryGirl.build(:shipping_mode, mode: nil)).not_to be_valid
    end
  end
end
