#---
# Adapted from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_arr for more book information.
#---
class ErrorHandlingFormBuilder < ActionView::Helpers::FormBuilder

  helpers = field_helpers +
    %w(date_select datetime_select time_select collection_select) +
    %w(collection_select select radio_select localized_country_select time_zone_select) -
    %w(label fields_for hidden_field)

  helpers.each do |name|
    define_method name do |field, *args|
      options = args.last.is_a?(Hash) ? args.last : {}
      build_shell(field, options) do
        super
      end
    end
  end

  def build_shell(field, options)
    locals = {
      :element => yield,
      :label => label(field, options[:label]),
      :help => options[:help]
    }
    if has_errors_on? field
      locals.merge! :error => error_message(field, options)
      partial = 'forms/field_with_errors'
    else
      partial = 'forms/field'
    end
    @template.render :partial => partial, :locals  => locals
  end
  
  def error_message(field, options)
    if has_errors_on?(field)
      errors = object.errors.on(field)
      errors.is_a?(Array) ? errors.to_sentence : errors
    else
      ''
    end
  end
  
  def has_errors_on?(field)
    !(object.nil? || object.errors.on(field).blank?)
  end
end
