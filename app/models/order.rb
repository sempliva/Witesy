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

class Order < ActiveRecord::Base
  validates  :customer_name, :order_number, :shipping_mode, :payment_term, :order_date, :ship_by, :items, presence: true
  validates_uniqueness_of :order_number
  # Validates ship by date. It must be greater than customer order date and order date
  validate :ship_by_after

  belongs_to :shipping_address, class_name: "Address", dependent: :destroy
  belongs_to :billing_address, class_name: "Address", dependent: :destroy

  # has_one :shipping_address, dependent: :destroy, as: :addressable, :class_name => "Address"
  # has_one :billing_address, dependent: :destroy, as: :addressable, :class_name => "Address"
  belongs_to :customer
  has_many :items, -> { order(item_number: :asc) }, dependent: :destroy

  accepts_nested_attributes_for :shipping_address
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :customer
  accepts_nested_attributes_for :items, :allow_destroy => true

  def customer_name
    customer.try(:name)
  end

  def customer_name=(name)
    self.customer = Customer.find_or_create_by(name: name) if name.present?
  end

  def ship_by_after
    if self.ship_by.present?
       if (self.order_date && self.ship_by < self.order_date)
         errors.add(:ship_by, 'ship_by date before customer order date or order date')
       end
    end
  end
end
