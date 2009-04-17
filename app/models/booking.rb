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
  has_many :adults, :dependent => :destroy
  has_many :children, :dependent => :destroy
  has_many :date_ranges, :dependent => :destroy
  
  validates_associated :adults
  validates_associated :children
  
  validates_associated :date_ranges
  
  before_create :make_booking_code
  
  accepts_nested_attributes_for :adults, :allow_destroy => true#, :reject_if => proc { |attrs| attrs['first_name'].blank? && attrs['last_name'].blank? }  
  accepts_nested_attributes_for :children, :allow_destroy => true#, :reject_if => proc { |attrs| attrs['first_name'].blank? && attrs['last_name'].blank? }  
  accepts_nested_attributes_for :date_ranges, :allow_destroy => true #, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  
  def to_param
    self.code
  end

  def days_in_itinerary
    days = []
    arriving_or_departing = ["morning", "afternoon", "evening"]
    
    self.date_ranges.each do |date_range|
      date_range.dates.each do |date|
        day = {}
        day[:arriving_or_departing] = "Arrving in the " + arriving_or_departing[date_range.arrival_time] if date == date_range.start_date
        day[:arriving_or_departing] = "Departing in the " + arriving_or_departing[date_range.departure_time] if date == date_range.end_date
        day[:date] = date
        day[:program] = get_program(date)
        days << day
      end
    end
  
    return days
  end
  
  def get_program(date)
    if date < ProgramDay.first.date
      return "Building up"
    elsif date >= ProgramDay.first.date and date <= ProgramDay.last.date
      return ProgramDay.find_by_date(date).description
    elsif date > ProgramDay.first.date
      return "Dissolving"
    end
  end  
  
  private
  
  def make_booking_code
    self.code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end
end