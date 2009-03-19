# == Schema Information
# Schema version: 20090317141210
#
# Table name: date_ranges
#
#  id         :integer         not null, primary key
#  start      :date
#  end        :date
#  arrival    :integer
#  departure  :integer
#  booking_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class DateRange < ActiveRecord::Base
  belongs_to :booking
end
