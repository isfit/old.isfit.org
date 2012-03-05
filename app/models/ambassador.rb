class Ambassador < ActiveRecord::Base
  belongs_to :country
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_presence_of :name
  validates_presence_of :country_id
  validates_presence_of :address
  validates_presence_of :zip_code
  validates_presence_of :city
  validates_presence_of :infopackage_contact_type_id
end
