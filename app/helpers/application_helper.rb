module ApplicationHelper

  # Builds a bootstrap compatible string field with error if any
  # options:
  # object
  # input_name
  # form
  # input_id
  # label_text
  def custom_string_field object, options
    if object.errors.any?
      if object.errors.keys.include? options[:input_name]
        custom_string_field_builder_with_error object, options
      else
        custom_string_field_builder options
      end
    else
      custom_string_field_builder options
    end
  end

  private
  def custom_string_field_builder options
    content_tag(:div, :class => 'control-group') do
      concat custom_label(options)
      concat text_input(object, options)
    end
  end

  def custom_string_field_builder_with_error object, options
    content_tag(:div, :class => 'control-group error') do
      concat custom_label(options)
      concat text_input(object, options, true)

    end
  end

  def custom_label options
    content_tag(:label, :class => 'control-label', :for => options[:input_id]) do
      concat options[:label_text]
    end
  end

  def error_display text
    content_tag(:span, :class => 'help-inline') do
      concat text
    end
  end

  def text_input object, options, error=false
    content_tag(:div, :class => 'controls') do
      concat options[:form].text_field options[:input_name], :id => options[:input_id]
      concat error_display(object.errors[options[:input_name]].join(', ')) if error
    end
  end
end
