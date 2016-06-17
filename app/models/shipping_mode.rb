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

class ShippingMode < ActiveRecord::Base
  include ApplicationHelper
  validates :mode, presence: true
  validates_uniqueness_of  :mode, :message => 'This Shipping mode has already been taken.'
  before_validation :strip_blanks

  protected
  def strip_blanks
    if self.mode
      self.mode = remove_whitespace(self.mode)
    end
  end
end
