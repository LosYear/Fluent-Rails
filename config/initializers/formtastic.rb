Formtastic::Helpers::FormHelper.builder = FormtasticBootstrap::FormBuilder

FormtasticBootstrap::Inputs::Base::Wrapping.module_eval do
	def bootstrap_wrapping(&block)
	  input_content = [
		add_on_content(options[:prepend]),
		options[:prepend_content],
		yield,
		add_on_content(options[:append]),
		options[:append_content],
		hint_html
	  ].compact.join("\n").html_safe

	  form_group_wrapping do
		label_html <<
		if prepended_or_appended?(options)
		  template.content_tag(:div, :class => add_on_wrapper_classes(options).join(" ")) do
			input_content
		  end
		else
		  div_class = options[:wrapper_class] || 'col-lg-8'
		  template.content_tag(:div, :class => div_class) do
			input_content
		  end
		end
	  end
	end
end

FormtasticBootstrap::Inputs::Base::Labelling.module_eval do
	def label_html_options
	  super.tap do |options|
		# Bootstrap defines class 'label' too, so remove the
		# one that gets created by Formtastic.
		options[:class] = options[:class].reject { |c| c == 'label' }
		label_class = @options[:label_class] || "col-lg-2 control-label"
		options[:class] << label_class
		options[:class]
	  end
	end
end