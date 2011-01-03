class AlumniReservation < ActiveRecord::Base
  validates :phone, :numericality => true, :uniqueness => true
  validates :firstname, :presence => true
  validates :surname, :presence => true
  validates :isfit_year, :numericality => true
end
