module BookingsHelper
  def this_person_is_or_i_am
    @group ? 'This person is' : 'I am'
  end
  
  def group_booking(person)
    @group or (@booking.people.length > 1 and @booking.people.first != person)
  end
  
  def additional(date_range)
    @additional_date_range or (@booking.date_ranges.length > 1 and @booking.date_ranges.first != date_range)
  end
end
