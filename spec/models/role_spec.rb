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

RSpec.describe Role, :type => :model do
  describe "associations" do
    it "it should have many assignments" do
      expect(Role.reflect_on_association(:assignments).macro).to eq :has_many
    end
    it "it should have many role through assignments" do
      expect(Role.reflect_on_association(:users).macro).to eq :has_many
    end
  end

  describe "validations" do
    it "has a valid factory" do
      FactoryGirl.build(:role)
    end
    it "is invalid without name" do
      expect(FactoryGirl.build(:role, name: nil)).not_to be_valid
    end
  end
end
