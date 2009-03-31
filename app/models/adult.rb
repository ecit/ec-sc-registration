# == Schema Information
# Schema version: 20090317141210
#
# Table name: people
#
#  id           :integer         not null, primary key
#  type         :string(255)
#  booking_id   :integer
#  first_name   :string(255)
#  last_name    :string(255)
#  country      :string(255)
#  sex          :string(255)
#  email        :string(255)
#  phone_number :string(255)
#  age          :integer
#  parent       :boolean
#  low_income   :boolean
#  helper       :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class Adult < Person
  validates_presence_of     :country, :sex, :message => "needs to be chosen"
  validates_presence_of     :email, :phone_number
  validates_uniqueness_of   :phone_number, :unless => "phone_number.empty?"
  validates_length_of       :email,    :within => 3..100, :unless => "email.empty?"
  validates_uniqueness_of   :email, :case_sensitive => false, :unless => "email.empty?"
  validates_format_of       :email, :with => /(^([^@\s]+)@((?:[-_a-z0-9]+\.)+[a-z]{2,})$)|(^$)/i, :message => "is not a valid address"
end
