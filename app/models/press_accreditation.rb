class PressAccreditation < ActiveRecord::Base
	validates :organization,  :presence => true
	validates :firstname, :presence => true
	validates :surname, :presence => true
	validates :function, :presence => true
	validates :day_period, :presence => true
	validates :email, :presence => true, :format => /[a-zA-Z0-9._%+-]+@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,4}/
	validates :phone, :presence => true
end