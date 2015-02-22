class BooleanInput < Formtastic::Inputs::BooleanInput
  def to_html
    template.content_tag :div, :class => 'form-group' do
      checkbox_wrapping do
        template.content_tag :div, :class => 'checkbox' do
          hidden_field_html <<
              "".html_safe <<
              [label_with_nested_checkbox, hint_html].join("\n").html_safe
        end
      end
    end
  end

  def hidden_field_html
    template.hidden_field_tag(input_html_options[:name], unchecked_value, :id => nil, :disabled => input_html_options[:disabled])
  end

  def label_with_nested_checkbox
    builder.label(
        method,
        label_text_with_embedded_checkbox,
        label_html_options
    )
  end

  def checkbox_wrapping(&block)
    template.content_tag(:div,
                         template.capture(&block).html_safe,
                         wrapper_html_options
    )
  end

  def wrapper_html_options
    super.tap do |options|
      options[:class] = (options[:class].split - ["form-group"] + ["col-lg-offset-2 col-lg-8"]).join(" ")
    end
  end
end