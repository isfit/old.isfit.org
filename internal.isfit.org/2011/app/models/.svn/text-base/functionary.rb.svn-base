class Functionary < ActiveRecord::Base

  
  validates_presence_of :study_place, :message => "Please fill in <i>Place of study </i> The field can't be left blank"
  validates_presence_of :study, :message => "Please fill in <i>Field of study</i>. The field can't be left blank"
  validates_format_of :private_mail, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "You must fill in a valid <i>Private e-mail</i>."
  validates_presence_of :next_of_kin_name, :message => "Please fill in <i>Next of kin's name</i>. The field can't be left blank"
  validates_presence_of :next_of_kin_tlf, :message => "Please fill in <i>Next of kin's phonenumber</i>. The field can't be left blank"

	validates_inclusion_of :have_group_card, :in => 0..1, :message => "Please specify whether you already have an internal Samfundet card (gjengkort) or not"

#  validate :validates_checkboxes

#  def validates_checkboxes
#    if no_allergies and no_allergies>0
#      if (vegetarian>0 || lactose>0 || gluten>0 || nut_allergy>0 || fruit>0 || other.size>0)
#        errors.add_to_base("<i>No dietary needs</i> and <i>Food intolerances</i> can not be checked at the same time ")
#      end
#    elsif (not (vegetarian or lactose or gluten or nut_allergy or fruit) or (vegetarian<1 && lactose<1 && gluten<1 && nut_allergy<1 && fruit<1 && other.size<1))
#      errors.add_to_base("At least one chechbox from <i>No dietary needs, Vegetarian, Lactose, Gluten, Nut allergy, Fruit intolerance or Other</i> must be checked")
#    end
#  end
def self.has_complete_info?(id)
		if Functionary.exists?(id)
			f = Functionary.find(id)
			f.valid? and
			f.cardnumber_ntnu != nil and 
			(f.cardnumber_ntnu == -1 or f.cardnumber_ntnu > 0) and
			f.cardnumber_samfundet != nil and f.cardnumber_samfundet > 0
		else
			false
		end
	end
end
