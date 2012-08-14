class Participant < ActiveRecord::Base
	belongs_to :country	

	# Constants defining identifiers for 
	# input data from wizard forms (ie. values from radio buttons etc)
	WIZARD_CARRIER_TRAIN	= "train"
	WIZARD_CARRIER_PLANE	= "air"
	WIZARD_CARRIER_OTHER	= "other"
	WIZARD_DATE_18FEB		= "18feb"
	WIZARD_DATE_19FEB		= "19feb"
	WIZARD_DATE_20FEB		= "20feb"
	WIZARD_DATE_OTHER		= "other"
	WIZARD_BUTTON_BACK		= "back"
	WIZARD_BUTTON_FORWARD	= "forward"
	WIZARD_PLACE_TRD		= "trd"
	WIZARD_PLACE_OSL		= "osl"
	WIZARD_PLACE_OTHER		= "otr"
	WIZARD_ISFIT_TRANS_YES	= true
	WIZARD_ISFIT_TRANS_NO	= false

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
	validates_presence_of :sex,  :message => "must be selected"	
	validates_presence_of :university
	validates_presence_of :field_of_study
#	validates_presence_of :workshop1,  :message => "Workshop 1 not selected"
#	validates_presence_of :workshop2,  :message => "Workshop 2 not selected"	
#	validates_presence_of :workshop3,  :message => "Workshop 3 not selected"

	# No longer validated to allow not being fetched from DB and still
	# make model validate ok
	validates_presence_of :essay1
	validates_presence_of :essay2
	validates_length_of :essay1, :maximum=>2500, :message => "Essay 1 too long"
	validates_length_of :essay2, :maximum=>2500, :message => "Essay 2 too long"
	validates_length_of :travel_essay, :maximum=>2000, :message => "Travel essay too long"

  validates :essay1, :length => {
    :maximum   => 260,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => " too long, maximum 250 words"
    }

  validates :essay2, :length => {
    :maximum   => 260,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => "too long, maximum 250 words"
    }

	validates_presence_of :birthdate, :message => "not valid"

	#Validate WSs
	validates_numericality_of :workshop1,:greater_than => 0, :message => "not selected"
	validates_numericality_of :workshop2,:greater_than => 0, :message => "not selected"
	validates_numericality_of :workshop3,:greater_than => 0, :message => "not selected"

	#Validate Email
  validates_format_of :email,
      			:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
      			:message => 'address is invalid.'
	validates_confirmation_of :email, :message => "address should match confirmation."
	validates_uniqueness_of :email, :message => " address is already in use."

  validates_inclusion_of :birthdate, :in => Date.new(1911)..Date.new(1995,2,7), 
    :message => "You need to be 18 years old when the festival starts"

	#Validate travel support

	# No longer validated as travel essay is not validated (look above)
	validates_presence_of :travel_essay, 
			:if => Proc.new { |n| n.travel_apply > 0 }
	validates_presence_of :travel_amount, 
			:if => Proc.new { |n| n.travel_apply > 0 }
	validates_numericality_of :travel_amount, :less_than_or_equal_to => 3000, :greater_than => 0,
      :if => Proc.new { |n| n.travel_apply > 0 || !n.travel_amount.empty? },
      :message => "must be a number, between 0 and 3000"

  validates :travel_essay, :length => {
    :maximum   => 210,
    :tokenizer => lambda { |str| str.scan(/\s+|$/) },
    :too_long  => "too long, maximum 200 words"
    }

	# Validate Wizard
	# Step 1
	validates_presence_of :arrival_date,
		:if => Proc.new {|part| part.respond_to?(:wizard_step) and part.wizard_step == 1},
		:message => "Please select when you will arrive in Norway (arrival date)"
	validates_presence_of :arrival_time, 
		:if => Proc.new {|part| part.respond_to?(:wizard_step) and part.wizard_step == 1},
		:message => "Please specify the time of your arrival in Norway"
	validates_presence_of :arrival_carrier, 
		:if => Proc.new {|part| part.respond_to?(:wizard_step) and part.wizard_step == 1},
		:message => "Please specify by what means of transport you will arrive in Norway. (Train, Airplane etc.)"
		
	# Step 2
	validates_presence_of :arrival_place, 
		:if => Proc.new {|part| part.respond_to?(:wizard_step) and part.wizard_step == 2},
		:message => "Please select and / or specify where in Norway you will arrive."
	validates_presence_of :arrival_airline,
		:if => Proc.new {
			|part| (part.respond_to?(:wizard_step) and part.wizard_step == 2 and 
			part.arrival_carrier == WIZARD_CARRIER_PLANE)},
		:message => "Please specify what airline you will arrive with."
	validates_presence_of :arrival_flight_number,
		:if => Proc.new {
			|part| (part.respond_to?(:wizard_step) and part.wizard_step == 2 and 
			part.arrival_carrier == WIZARD_CARRIER_PLANE)},
		:message => "Please specify flight number for the flight you are arriving in Norway with."
	
	# Step 3
	validates_inclusion_of :arrival_isfit_trans, 
		:in => [true, false],
		:if => Proc.new {|part| part.respond_to?(:wizard_step) and part.wizard_step == 3},
		:message => "Please indicate whether you will sign up for the ISFiT transportation or not."

	# Step 4
	validates_presence_of :departure_date, 
		:if => Proc.new {|part| part.respond_to?(:wizard_step) and part.wizard_step == 4},
		:message => "Please indicate at what date you will depart from Norway."
	validates_presence_of :departure_time, 
		:if => Proc.new {|part| part.respond_to?(:wizard_step) and part.wizard_step == 4},
		:message => "Please indicate the time when you will leave Norway."
	validates_presence_of :departure_carrier, 
		:if => Proc.new {|part| part.respond_to?(:wizard_step) and part.wizard_step == 4},
		:message => "Please select what means of transportation you will use when departing from Norway."
		
	# Step 5
	validates_presence_of :departure_place, 
		:if => Proc.new {|part| part.respond_to?(:wizard_step) and part.wizard_step == 5},
		:message => "Please select and / or specify where in Norway you will depart from."
	# Step 6
	validates_inclusion_of :departure_isfit_trans, 
		:in => [true, false],
		:if => Proc.new {|part| part.respond_to?(:wizard_step) and part.wizard_step == 6},
		:message => "Please indicate whether you will sign up for the ISFiT transportation or not."

  validates_exclusion_of :workshop1, :in => lambda { |p| [p.workshop2, p.workshop3] }, :message => "Please choose different workshops"
  validates_exclusion_of :workshop2, :in => lambda { |p| [p.workshop1, p.workshop3] }, :message => "Please choose different workshops"
  validates_exclusion_of :workshop3, :in => lambda { |p| [p.workshop1, p.workshop2] }, :message => "Please choose different workshops"

  def is_radio_button_date
		if arrival_date.eql? Date::new(2009, 02, 18) \
			or arrival_date.eql? Date::new(2009, 02, 19) \
			or arrival_date.eql? Date::new(2009, 02, 20)
			return true
		else
			return false
		end
	end
	
	def get_custom_arrival_place
		if arrival_place == Participant::WIZARD_PLACE_TRD or 
			arrival_place == Participant::WIZARD_PLACE_OSL
			return ""
		else
			return arrival_place
		end
	end
	
	def get_custom_departure_place
		if departure_place == Participant::WIZARD_PLACE_TRD or 
			departure_place == Participant::WIZARD_PLACE_OSL
			return ""
		else
			return departure_place
		end
	end
	
	def isfit_arrival_trans?
		# determines if this participant's travel
		# details make him / her qualify for the ISFiT Transportation
		if arrival_place == WIZARD_PLACE_OSL and
			(arrival_date.day < 20 or 
			(arrival_date.day == 20 and arrival_time.hour == 0 and
			arrival_time.min == 0)) and
			arrival_date.month == 2
			return true
		else
			return false
		end
	end
	
	def isfit_departure_trans?
		# determines if this participant's travel
		# details make him / her qualify for the ISFiT Transportation
		if departure_place == WIZARD_PLACE_OSL
			return true
		else
			return false
		end
	end
	
	def self.count_beds
	  connection.select_one("SELECT COUNT(*) AS beds FROM participants WHERE bed=1")["beds"].to_i
	end
	def self.count_beddings
	  connection.select_one("SELECT COUNT(*) AS beddings FROM participants WHERE bedding=1")["beddings"].to_i
	end
end
