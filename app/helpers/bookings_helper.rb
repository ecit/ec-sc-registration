module BookingsHelper
  def add_date_range_link(name, form_builder)
     button_to_function name do |page|
       form_builder.fields_for :date_ranges, DateRange.new, :child_index => 'NEW_RECORD' do |form|
         html = render(:partial => 'date_range', :locals => { :f => form })
         page << "$('date_ranges').insert({ bottom: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
       end
     end
  end

  def add_person_link(name, form_builder, kind)
     button_to_function name do |page|
       form_builder.fields_for kind.to_s.downcase.pluralize, kind.new, :child_index => 'NEW_RECORD' do |form|
         html = render(:partial => 'person', :locals => { :f => form, :person => kind })
         page << "$('people').insert({ bottom: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
       end
     end
  end

  def remove_form_link(name, form_builder, type)
    if form_builder.object.new_record?
      link_to_function(name, "$(this).up('.#{type}').remove();", :class => 'remove');
    else
      form_builder.hidden_field(:_delete) +
      link_to_function(name, "$(this).up('.#{type}').hide(); $(this).previous().value = '1'", :class => 'remove')
    end
  end
  
  def this_person_is_or_i_am
    @group ? 'This person is' : 'I am'
  end
  
  def format_date(date)
    "#{Date::DAYNAMES[date.wday].first(3)} #{date.day} #{Date::MONTHNAMES[date.mon].first(3)}"
  end
  
  def in_program?(date)
    (ProgramDay.all.map {|d| d.date}).include?(date)
  end
  
  def error_message(field, object)
    if !(object.nil? || object.errors.on(field).blank?)
      errors = object.errors.on(field)
      errors.is_a?(Array) ? errors.to_sentence : errors
    else
      ''
    end
  end
end