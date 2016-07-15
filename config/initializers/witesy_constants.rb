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

# Few Witesy-specific constants.

module WitesyConfiguration
  INPUT_ALLOWED_SYMBOLS = /\A[a-zA-Z0-9]+\z/
  PAGINATION_PREFERENCE = 50
  SALT = ENV['SALT'] ||= 'WITESYEMPTYSALT'

  module Auth
    USERNAME = ENV['HTTP_AUTH_USERNAME']
    PASSWORD = ENV['HTTP_AUTH_PASSWORD']
  end
  module Mail
    # Postmark has to be aware of the following value ("Signatures" on postmarkapp.com).
    # WARNING: outbound mail won't work with unauthorized sender!
    SENDER = 'john@0xf0.eu'
  end
end
