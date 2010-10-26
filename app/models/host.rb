class Host < ActiveRecord::Base

  validates_presence_of :first_name, :last_name, :email, :phone, :address, :zipcode, :place, :age, :number
  validates_inclusion_of :age, :in => 18..100
  validates_inclusion_of :number, :in => 1..10
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

end
