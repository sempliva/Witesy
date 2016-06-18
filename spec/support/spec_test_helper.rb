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

module SpecTestHelper
  def login()
    role = FactoryGirl.build(:role)
    user = FactoryGirl.build(:user, :user_admin_confirmed, :id => "1", :roles => [role])
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(WitesyConfiguration::Auth::USERNAME,WitesyConfiguration::Auth::PASSWORD)
    session[:user_id] = user.id
    $current_user = user
  end
end
