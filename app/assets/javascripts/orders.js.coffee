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

window.div_startingWith_item = "div[id^='item_']";

# Used to attach the Datepicker Widget to all text_field field with 'datepicker' css class.
# Set the defaultDate to an existing value or Today.
$(document).on 'focus', ".datepicker", (event) ->
  $( ".datepicker" ).datepicker({
    dateFormat: "yy-mm-dd"
    beforeShowDay: (date) ->
      if this.value
        defaultDate: this.value
      else
        defaultDate: new Date()
      return [date.getDate(), ''];
  });

# "Add Item" links.
$(document).on 'click', '.add_fields_item', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

# Used to remove the item div with class 'remove_fields_item' if the current analysis has at least one item left
$(document).on 'click', "form .remove_fields_item", (event) ->
   removable_item = $(this).closest('div.item');
   size = $('div.items').children(".item").size()
   if size > 1
     removable_item.remove()
   event.preventDefault()


# XHR for the autocompletion field in NewOrder (customer).
$(document).on 'autocompleteselect', '#order_customer_name', (event, ui) ->
  if $(this).val() != undefined && $(this).val() != ""
    customer_name = ui.item.value
    $.ajax
      url: '/orders/load_by_customer_name',
      type: 'GET',
      headers: {'customer_name' : customer_name},
      dataType: 'json',
      success: (data, status, xhr) ->
          $('#order_customer_attributes_label').val(data.label).attr('disabled', 'disabled');
          $('#order_customer_attributes_id').val(data.id);
          $.ajax
            url: '/orders/load_contacts_by_customer_name/'
            type: 'GET',
            headers: {'customer_name' : customer_name},
            dataType: 'json',
            success: (data, status, xhr) ->
              $("#order_billing_address_attributes_contact_name").autocomplete(
                source: data
                select: (event, ui) ->
                  $.ajax
                    url: '/orders/load_address/',
                    type: 'GET',
                    headers: {'contact_name' : ui.item.value, 'customer_name' : customer_name},
                    dataType: 'json',
                    success: (data, status, xhr) ->
                      $('#order_billing_address_attributes_contact_name').val(data.contact_name)
                      $('#order_billing_address_attributes_street').val(data.street).attr('disabled', 'disabled');
                      $('#order_billing_address_attributes_city').val(data.city).attr('disabled', 'disabled');
                      $('#order_billing_address_attributes_zip').val(data.zip).attr('disabled', 'disabled');
                      $('#order_billing_address_attributes_state').val(data.state).attr('disabled', 'disabled');
              ) # autocomplete end.
    get_last_customer_shipping_mode(customer_name);


# Used on blur customer name to load last shipping mode
window.get_last_customer_shipping_mode = (customer_name) ->
  $.ajax
    url: '/orders/get_last_customer_shipping_mode/'
    type: 'GET',
    headers: {'customer_name' : customer_name},
    dataType: 'json',
    success: (data, status, xhr) ->
        if(data)
          $('#order_shipping_mode').val(data.shipping_mode);


# Used to manage autocompletion field in NewOrder (customer) after changing customer contact name input value
$(document).on 'autocompletesearch', '#order_customer_name', (event, ui) ->
  # Clean all addresses fields
  clear_customer_fields()
  clear_addresses_fields()
  # Used to remove underlyng billing autocompletion data source
  if $( "#order_billing_address_attributes_contact_name" ).hasClass("ui-autocomplete-input")
    disable_autocomplete_contact_billing()


# Used to manage autocompletion field in NewOrder (customer) after changing customer contact name input value
$(document).on 'autocompletesearch', '#order_billing_address_attributes_contact_name', (event, ui) ->
  # Clean all addresses fields
  clear_addresses_fields()


# Used to clear all addresses fields
window.clear_addresses_fields = ->
  # clear shipping address
  $('#order_billing_address_attributes_contact_name').val("").removeAttr('disabled');
  $('#order_billing_address_attributes_street').val("").removeAttr('disabled');
  $('#order_billing_address_attributes_city').val("").removeAttr('disabled');
  $('#order_billing_address_attributes_zip').val("").removeAttr('disabled');
  $('#order_billing_address_attributes_state').val("").removeAttr('disabled');
  $('#order_billing_address_attributes_id').val("");
  # clear billing address
  $('#order_shipping_address_attributes_contact_name').val("")
  $('#order_shipping_address_attributes_street').val("")
  $('#order_shipping_address_attributes_city').val("")
  $('#order_shipping_address_attributes_zip').val("")
  $('#order_shipping_address_attributes_state').val("")


# "Same as Billing Address" link.
$(document).on 'click', '#clone_address', (event) ->
  $('#order_shipping_address_attributes_contact_name').val($('#order_billing_address_attributes_contact_name').val())
  $('#order_shipping_address_attributes_street').val($('#order_billing_address_attributes_street').val())
  $('#order_shipping_address_attributes_city').val($('#order_billing_address_attributes_city').val())
  $('#order_shipping_address_attributes_zip').val($('#order_billing_address_attributes_zip').val())
  $('#order_shipping_address_attributes_state').val($('#order_billing_address_attributes_state').val())
  event.preventDefault()


# Used to change mode in the list order, giving the ability to select orders.
$(document).on 'click', ".toggle_selection_orders", (event) ->
  tc = $('.toggle_checkbox')
  new_val = 'none'
  new_val = 'initial' if tc.css('display') == 'none'
  tc.css('display', new_val)
  tc.attr('width', '500')
  tc.attr('checked', false)
  tmi = $('#toggle_menu_item')
  tmi.css('visibility', 'hidden') if tmi.css('visibility') == 'visible'


# This handler kicks in when one of the List Orders checkboxes gets toggled,
# mainly to enable or disable the "Delete" button at the bottom of the
# page if there is at least one active (checked) checkbox.
$(document).on 'change', ".toggle_checkbox", (event) ->
  cb = $(".toggle_checkbox:checked")
  new_val = 'hidden'
  new_val = 'visible' if cb.length > 0
  $('#toggle_menu_item').css('visibility', new_val)

# Used to retrieve all the selected orders and sent them as get params to the orders controller
#$(document).on 'click', "#delete_orders", (event) ->
window.delete_orders = ->
  alert("a");
  orders_ids = [];
  $(".toggle_checkbox:checked").each ->
    orders_ids.push $(this).attr("value")
  $.ajax
    url: '/orders/destroy_multiple/'
    type: 'DELETE',
    data : {orders_ids}
  event.preventDefault();

# Used to clear all addresses fields
window.clear_customer_fields = ->
  # clear customer fields
  $('#order_customer_attributes_label').val("").removeAttr('disabled');
  $('#order_customer_attributes_id').val("");

# Used to remove autocomplete data source for billing address
window.disable_autocomplete_contact_billing =  ->
   $("#order_billing_address_attributes_contact_name").autocomplete("destroy")

# Used to populate the autocompletion input field in NewOrder (customer).
$ ->
  $('#order_customer_name').autocomplete
    source: $('#order_customer_name').data('autocomplete-source')

# Handler for order items clicked from the homepage.
window.order_clicked = (item) ->
  window.location.href = "/orders/#{item}"

# Remove attributes disabled before submitting edit order form and new order form
$(document).on 'submit', "form[class='edit_order'], form[class='new_order']", (event) ->
  $("[id ^='order_billing_address_attributes_']").removeAttr("disabled");

# Prevent form submission on enter key pressed
$(document).on 'keypress', "form", (event) ->
  if (event.keyCode == 13)
    event.preventDefault();
