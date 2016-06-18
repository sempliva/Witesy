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

include ApplicationHelper
require 'securerandom'
class User < ActiveRecord::Base
  validates :nickname, :email, :password, presence: true
  validates :nickname, format: { with: WitesyConfiguration::INPUT_ALLOWED_SYMBOLS, message: "The only value allowed are: alphanumeric values" }
  validates :nickname, length: { maximum: 15, minimum: 6 }
  validates :password, length: { minimum: 6 }
  validates_uniqueness_of :email, :nickname

  has_many :assignments
  has_many :roles, through: :assignments

  # Used to validate the field password_confirmation.
  validates :password, confirmation: true
  validates_uniqueness_of :email

  before_create :hash_password

  # Check if the user has a specific role.
  def role?(role)
    roles.any? { |r| r.name.underscore.to_sym == role }
  end

  protected
  def hash_password
    self.salt ||= SecureRandom.hex
    self.password = witesy_digest(self.salt, self.password)
  end
end
