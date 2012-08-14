class DialogueParticipant < ActiveRecord::Base
	belongs_to :country	

#	validates_presence_of :password, :message => "A password must be supplied."
#	validates_length_of :password, :in => 8..255,
#		:too_short => "Password must be between 8 and 255 characters.",
#		:too_long => "Password must be between 8 and 255 characters."

	#Validate General
	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_presence_of :address1
	validates_presence_of :zipcode
	validates_presence_of :city
	validates_inclusion_of :country_id, :in => 1..210, :message => "not selected"
	validates_presence_of :phone
	validates_presence_of :nationality
	validates_presence_of :passport
	validates_presence_of :sex	
	validates_presence_of :university
	validates_presence_of :field_of_study
	validates_presence_of :essay1
	validates_presence_of :essay2
	validates_presence_of :essay3
	validates_presence_of :essay4
	validates_presence_of :birthdate
	validates_presence_of :apply_workshop, :message => "Have you applied or will you apply for ISFiT Workshop?"

	#Validate essay-length
	validates_length_of :essay1, :maximum=>2200, :message => "Essay 1 too long"
	validates_length_of :essay2, :maximum=>2200, :message => "Essay 2 too long"
	validates_length_of :essay3, :maximum=>2200, :message => "Essay 3 too long"
	validates_length_of :essay4, :maximum=>1200, :message => "Essay 4 too long"
	validates_length_of :travel_essay, :maximum=>1500, :message => "Travel essay too long"
	
  #Validate max words in eassy	

  validates :essay1, :length => {
    :maximum => 310,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long => " too long, maximum 300 words"
    }

  validates :essay2, :length => {
    :maximum => 310,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long => " too long, maximum 300 words"
    }

  validates :essay3, :length => {
    :maximum => 310,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long => " too long, maximum 300 words"
    }

  validates :essay4, :length => {
    :maximum => 160,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long => " too long, maximum 150 words"
    }

	#Validate Email
  validates_format_of :email,
      			:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
      			:message => 'must be valid'
	validates_confirmation_of :email, :message => "should match confirmation"
	validates_uniqueness_of :email, :message => "An application with this email address has already been registered"

  validates_inclusion_of :birthdate, :in => Date.new(1911)..Date.new(1995,1,28), 
    :message => "You need to be 18 years old when the festival starts"

end
