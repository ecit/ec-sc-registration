module BookingHelper
  def this_person_is_or_i_am
    @group ? 'This person is' : 'I am'
  end
end
