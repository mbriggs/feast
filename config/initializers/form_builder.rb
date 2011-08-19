module ActionView
  module Helpers
    class FormBuilder
      def food(quantity=nil, name)
        quantity ||= 1
        title = @template.pluralize(quantity, name)
        id = title.parameterize

        [ @template.check_box(@object_name, name, {id: id}, quantity, 0),
          label(name, title, {for: id}),
          "<br/>" ].join("\n").html_safe
      end
    end
  end
end
