class Booking < ActiveRecord::Base
  has_many :people
  has_many :date_ranges
end
