class AlumniReservation < ActiveRecord::Base
  validates :phone, :numericality => true, :uniqueness => true
  validates :firstname, :presence => true
  validates :surname, :presence => true
  validates :isfit_year, :numericality => true
  validates :mail, :format => /[a-zA-Z0-9._%+-]+@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,4}/, :uniqueness => true
end
