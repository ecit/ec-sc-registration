module ActionView
  module Helpers

    module FormOptionsHelper
      def radio_select(object, method, choices, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_radio_select_tag(choices, options, html_options)
      end
    end

    class InstanceTag
      def to_radio_select_tag(choices, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        name = html_options.delete 'name'
        value = value(object)
        delimiter = options.delete(:delimiter) || ' '
        choices.map do |choice|
          label_tag "#{name}_#{choice[1]}", "#{radio_button_tag name, choice[1], choice[1] == value}#{choice[0]}"
        end.join delimiter
      end
    end
    
    class FormBuilder
      def radio_select(method, choices, options = {}, html_options = {})
        @template.radio_select(@object_name, method, choices, options.merge(:object => @object), html_options)
      end
    end

  end
end