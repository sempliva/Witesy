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

class Customer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :label, type: String
  validates :label, length: { maximum: 20 }
  validates_uniqueness_of :name
  validates_uniqueness_of :label
  validates :name, :label, format: { with: WitesyConfiguration::INPUT_ALLOWED_SYMBOLS, message: "The only value allowed are: , - . & alphanumeric values" }

  embeds_many :addresses
  accepts_nested_attributes_for :addresses, :allow_destroy => true
  def name=(value)
    write_attribute(:name, value.try(:strip))
  end
end
