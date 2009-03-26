# == Schema Information
# Schema version: 20090317141210
#
# Table name: bookings
#
#  id         :integer         not null, primary key
#  code       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Booking < ActiveRecord::Base
  has_many :people
  has_many :date_ranges
    
  def new_person_attributes=(person_attributes)
    person_attributes.each do |attributes|
      type = attributes[:type]
      logger.debug "type #{type}"
      case type
      when 'Child'
        person = Child
      when 'Adult'
        person = Adult
      end
      self.people << person.new(attributes)
    end 
  end

  def new_date_range_attributes=(date_range_attributes)
    date_range_attributes.each do |attributes|
      date_ranges.build(attributes)
    end 
  end
end
