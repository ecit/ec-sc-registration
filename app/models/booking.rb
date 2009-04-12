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
  has_many :people, :dependent => :destroy
  has_many :date_ranges, :dependent => :destroy
    
  validates_associated :people
  validates_associated :date_ranges
  
  before_create :make_booking_code
  after_update :save_people 

  def make_booking_code
    self.code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end
    
  def new_person_attributes=(person_attributes)
    person_attributes.each do |attributes|
      type = attributes[:type]
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

  def existing_person_attributes=(person_attributes)
    people.reject(&:new_record?).each do |person| 
      attributes = person_attributes[person.id.to_s]
      if attributes
        type = attributes[:type]
        case type
        when 'Child'
          person = Child
        when 'Adult'
          person = Adult
        end
      
        person.attributes = attributes 
      else 
        people.delete(person) 
      end 
    end 
  end 

  def save_people
    people.each do |person| 
      person.save(false) 
    end 
  end
end
