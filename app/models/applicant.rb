class Applicant < ActiveRecord::Base
  validates_presence_of :firstname
  validates_presence_of :lastname
  validates_format_of :mail, 
  :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_format_of :phone, :with => /^\d{8}$/
  validates_presence_of :information 
  validates_presence_of :background 
  validates_presence_of :heardof
  validates_numericality_of :position_id_1, :greater_than => 0


  def self.validate_field(field, value)
    validity = Applicant.new(field => value)
    validity.valid?
    if validity.errors.on field
      ajaxResponse = {:valid => false, field.to_sym => validity.errors[:field]}
    else
      ajaxResponse = {:valid => true}
    end
  end
end
