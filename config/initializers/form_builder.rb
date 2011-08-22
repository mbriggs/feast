module ActionView
  module Helpers
    class FormBuilder
      def food(quantity=nil, name)
        if quantity
          title = @template.pluralize(quantity, name)
        else
          quantity = 1
          title = name
        end

        id = title.parameterize

        [ @template.check_box(@object_name, name, {id: id, checked: false}, quantity, 0),
          label(name, title, {for: id}),
          "<br/>" ].join("\n").html_safe
      end
    end
  end
end
