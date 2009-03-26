module BookingHelper
  def this_person_is_or_i_am
    @group ? 'This person is' : 'I am'
  end
  
  def group_booking(person)
    @group or (@booking.people.length > 1 and @booking.people.first != person)
  end
end
