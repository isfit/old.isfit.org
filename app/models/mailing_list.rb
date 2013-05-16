class MailingList < ActiveRecord::Base
  attr_accessible :email

  validates_format_of :email,
      			:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
      			:message => 'address is invalid.'
	validates_uniqueness_of :email, :message => " address is already in use."
end
