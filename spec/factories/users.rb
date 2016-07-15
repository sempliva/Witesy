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
  factory :user do
    trait :user_admin_confirmed do
      nickname "adminuser"
      email "admin@email.com"
      password "password"
      salt "salt"
      confirmed_email "true"
      last_login "2014-12-30"
    end

    trait :user_one do
      nickname "nickname"
      email "email@email.com"
      password "password"
      salt "salt"
      confirmed_email "true"
      last_login "2014-12-30"
    end
    trait :user_two do
      nickname "nickname2"
      email "email@w.com"
      password "password"
      salt "salt"
      confirmed_email "true"
      last_login "2014-12-30"
    end
    trait :user_three do
      nickname "nickname3"
      email "email@b.com"
      password "password"
      salt "salt"
      confirmed_email "true"
      last_login "2014-12-30"
    end
    trait :user_four do
      nickname "nickname4"
      email "a@b.com"
      password "password"
      salt "salt"
      confirmed_email "true"
      last_login "2014-12-30"
    end
  end
end
