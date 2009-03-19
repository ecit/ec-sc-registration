# == Schema Information
# Schema version: 20090317141210
#
# Table name: people
#
#  id           :integer         not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  country      :string(255)
#  sex          :string(255)
#  email        :string(255)
#  phone_number :string(255)
#  parent       :boolean
#  low_income   :boolean
#  helper       :boolean
#  type         :string(255)
#  booking_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Child < Person
end
