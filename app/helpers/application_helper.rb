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
module ApplicationHelper
  # A little bit of explanation: this creates a new link to add new content
  # dynamically.
  def link_to_add_fields(name, f, association, css_class)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end

    # Here we create the link with the data-field attribute which, at the end of
    # the day, contains the actual DOM subtree to create a new node.
    # 'data' contains the content to add.
    link_to(name, '#', class: css_class, data: { id: id, fields: fields.gsub("\n", "") })
  end

  # Used to remove extra leading, trailing and inner whitespace
  def remove_whitespace(value)
    value = value.strip
    value = value.squeeze(" ")
  end

  # Function to generate password digests, used almost everywhere.
  def witesy_digest(salt, password)
    Digest::SHA2.hexdigest(salt + WitesyConfiguration::SALT + password)
  end

end
