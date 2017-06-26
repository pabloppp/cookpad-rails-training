module ApplicationHelper
  def link_to_add_nested(text, form, association)
    singular_name = association.to_s.singularize
    object = form.object.public_send(association).build

    template = form.fields_for(association, object,
                               child_index: "__ID__") do |nested_form|
      render "#{singular_name}_fields", form: nested_form
    end

    link_to text, "#", data: { role: "add-nested", template: template },
                       class: "button-light"
  end
end
