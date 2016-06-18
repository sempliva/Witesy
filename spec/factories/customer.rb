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

FactoryGirl.define do
  factory :customer do
    trait :customer do
      name "Abc"
      label "ABc"
      addresses {[FactoryGirl.create(:address)]}
    end

    trait :customer_one do
      name "John"
      label "DoeJohn"
      addresses {[FactoryGirl.create(:address)]}
    end
    trait :customer_one do
      name "John"
      label "DoeJohn"
      addresses {[FactoryGirl.create(:address)]}
    end

  trait :customer_two do
    name "John 2"
    label "DoeJohn2"
    addresses {[FactoryGirl.create(:address)]}
  end

  trait :customer_three do
    name "John 3"
    label "DoeJohn3"
    addresses {[FactoryGirl.create(:address)]}
  end

  trait :customer_four do
    name "John4"
    label "DoeJohn4"
    addresses {[FactoryGirl.create(:address)]}
  end
  trait :customer_five do
    name "John5"
    label "DoeJohn5"
    addresses {[FactoryGirl.create(:address)]}
  end
  trait :customer_six do
    name "John6"
    label "DoeJohn6"
    addresses {[FactoryGirl.create(:address)]}
  end
end
end
