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
describe ApplicationPolicy do
  subject { described_class }

  permissions :update?, :edit?, :new?, :destroy? do
    it "denies access on customer if user is not admin" do
      address = FactoryGirl.build(:address)
      customer = FactoryGirl.build(:customer, :addresses => [address])
      role = FactoryGirl.build(:role, name: "user")
      user = FactoryGirl.build(:user, :user_one, roles: [role])
      expect(subject).not_to permit(user, customer)
    end

    it "grants access on customer if user is an admin" do
      address = FactoryGirl.build(:address)
      customer = FactoryGirl.build(:customer, :addresses => [address])
      role = FactoryGirl.build(:role, name: "admin")
      user = FactoryGirl.build(:user, :user_one, roles: [role])
      expect(subject).to permit(user, customer)
    end

    it "denies access on order if user is not admin" do
      address = FactoryGirl.build(:address)
      customer = FactoryGirl.build(:customer, :addresses => [address])
      role = FactoryGirl.build(:role, name: "user")
      user = FactoryGirl.build(:user, :user_one, roles: [role])
      expect(subject).not_to permit(user, customer)
    end

    it "grants access on order if user is an admin" do
      address = FactoryGirl.build(:address)
      customer = FactoryGirl.build(:customer, :addresses => [address])
      role = FactoryGirl.build(:role, name: "admin")
      user = FactoryGirl.build(:user,  :user_one, roles: [role])
      expect(subject).to permit(user, customer)
    end
  end
end
