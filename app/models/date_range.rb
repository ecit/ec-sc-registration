# == Schema Information
# Schema version: 20090317141210
#
# Table name: date_ranges
#
#  id         :integer         not null, primary key
#  start_date      :date
#  end_date        :date
#  arrival_time    :integer
#  departure_time  :integer
#  booking_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class DateRange < ActiveRecord::Base
  belongs_to :booking

  attr_accessor :raise_exception
  
  after_save :raise_exception_if_needed
  
  def raise_exception_if_needed
    if @raise_exception.to_i == 1
      raise 'Oh noes!'
    end
  end

  # End date < Start date
  def validate
    errors.add("departure before arrival ") if self.end_date < self.start_date
    #errors.add("first booking date is the first of July" if self.end_date ==)
  end
  
  def nr_of_days
    end_date.yday - start_date.yday + 1
  end
  
  def dates
    dates = []
    day = 0
    
    nr_of_days.times do
      date = start_date + day
      day += 1
      dates << date
    end
    return dates
  end
end
