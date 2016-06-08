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

class Address
  # store_in collection: "addresses"

  include Mongoid::Document
  include Mongoid::Timestamps
  field :contact_name, type: String
  field :street, type: String
  field :city, type: String
  field :state, type: String
  field :zip, type: String
  field :country, type: String

  validates :street, :city, :state, :zip, presence: true
  validates :state, length: { is: 2 }
  after_initialize :init
  embedded_in :customer, :inverse_of => :addresses

  def init
    self.country ||= "USA"
  end

  def state=(value)
    write_attribute(:state, value.upcase)
  end

  def contact_name=(value)
    write_attribute(:contact_name, value.try(:strip))
  end
end
