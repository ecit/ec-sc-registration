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

  # End date < Start date
  def validate
    errors.add("departure before arrival?") if self.end_date < self.start_date
  end
end
