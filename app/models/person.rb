class Person < ActiveRecord::Base
  belongs_to :booking
end

class Adult < Person
end

class Child < Person
end
