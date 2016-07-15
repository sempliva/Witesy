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

RSpec.describe User, :type => :model do
  describe "associations" do
    it "it should have many assignments" do
      expect(User.reflect_on_association(:assignments).macro).to eq :has_many
    end
    it "it should have many role through assignments" do
      expect(User.reflect_on_association(:roles).macro).to eq :has_many
    end
  end

  describe "validations" do
    it "has a valid factory" do
      FactoryGirl.build(:user)
    end
    it "is invalid without nickname" do
      expect(FactoryGirl.build(:user, :user_one, nickname: nil)).not_to be_valid
    end
    it "is invalid without email" do
      expect(FactoryGirl.build(:user, :user_one, email: nil)).not_to be_valid
    end
    it "is invalid without password" do
      expect(FactoryGirl.build(:user, :user_one, password: nil)).not_to be_valid
    end
    it "is invalid with a nickname length more than 15" do
      expect(FactoryGirl.build(:user, :user_one, nickname: "abcdefghilmnopqrstuvz")).not_to be_valid
    end
    it "is invalid with a nickname length less than 6" do
      expect(FactoryGirl.build(:user, :user_one, nickname: "abc")).not_to be_valid
    end
    it "is invalid with a password length less than 6" do
      expect(FactoryGirl.build(:user, :user_one, password: "abc")).not_to be_valid
    end
    it "is invalid with a nickname format containing non alhpanumeric symbols" do
      expect(FactoryGirl.build(:user, :user_one, nickname: "_C&°  ")).not_to be_valid
    end
    it "has unique email" do
      user = FactoryGirl.create(:user, :user_one, email: "a@a.it")
      expect { FactoryGirl.create(:user, :user_one, email: "a@a.it") }.to raise_error( ActiveRecord::RecordInvalid)
    end
    it "has unique nickname" do
      user = FactoryGirl.create(:user, :user_two, nickname: "alphabeta")
      expect { FactoryGirl.create(:user, :user_two, nickname: "alphabeta") }.to raise_error( ActiveRecord::RecordInvalid)
    end
  end
end
