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
end
