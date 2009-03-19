# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def button_to_remote(name, options = {}, html_options = {})
    button_to_function(name, remote_function(options), html_options)
  end

  def error_handling_form_for(record_or_name_or_array, *args, &block)
    options = args.extract_options!
    options[:builder] ||= ErrorHandlingFormBuilder
    args << options
    form_for(record_or_name_or_array, *args, &block)
  end
end
