class Applicant < ActiveRecord::Base
	belongs_to :first_position, :class_name => 'Position',
		:foreign_key => 'position_id_1', :include => [:section]
	belongs_to :second_position, :class_name => 'Position',
		:foreign_key => 'position_id_2'
	belongs_to :third_position, :class_name => 'Position',
		:foreign_key => 'position_id_3'

	cattr_reader :per_page
	@@per_page = 300

	validates_presence_of :firstname, :message => "Firstname is missing"
	validates_presence_of :lastname, :message => "Last name is missing"
	validates_format_of :mail, 
		:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
		:message => "The supplied e-mail address is no valid"
	validates_format_of :phone, :with => /^\d{8}$/,	
		:message => "Phone number must consist of exactly 8 digits"
	validates_presence_of :information, 
		:message => "Information about you is missing"
	validates_presence_of :background, 
		:message => "Relevant experience is missing"
	validates_numericality_of :position_id_1, :greater_than => 0, 
		:message => "At least one position must be selected"

end
