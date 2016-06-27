# Copyright (C) 2016 Witesy Contributors
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.customer_clicked = (item) ->
  window.location.href = "/customers/#{item}"

# "Add Address" links.
$(document).on 'click', '.add_fields_address', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

# Used to remove the address div with class 'remove_fields_address' if the current customer has at least one address left
$(document).on 'click', 'form .remove_fields_address', (event) ->
  removable_address = $(this).closest("div.address")
  size = $("div.customer_addresses").children(".address").size()
  if size > 1
    removable_address.remove()
  event.preventDefault()
