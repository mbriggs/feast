module ApplicationHelper
  def food(quantity=nil, name)
    if quantity
      checkbox \
        id: "#{quantity}-#{name.downcase.dasherize}",
        title: pluralize(quantity, name),
        value: quantity
    else
      checkbox title: name, value: 1
    end
  end

private
  def checkbox(args)
    id, value, title = destructure_check_args(args)

    id ||= title.camelize.downcase.dasherize
    label = content_tag :label, title, for: id
    checkbox = "<input id='#{id}' type='checkbox' value='#{value}'/>"

    "#{checkbox}\n#{label}<br/>".html_safe
  end

  def destructure_check_args(args)
    return [args[:id], args[:value], args[:title]]
  end
end
