class Participant < ActiveRecord::Base

	belongs_to :country
	belongs_to :host
	has_one :answer, :class_name => "Answer", :foreign_key => "id"
  
	cattr_reader :per_page
	@@per_page = 20

    #Validate General
    validates_presence_of :first_name, :message => "First name can't be blank"
    validates_presence_of :last_name, :message => "Last name can't be blank"
    validates_presence_of :address1, :message => "Address 1 can't be blank"
    validates_presence_of :zipcode, :message => "ZIP code can't be blank"
    validates_presence_of :city, :message => "City can't be blank"
    validates_inclusion_of :country_id, :in => 1..200, 
		:message => "Country not selected"
    validates_presence_of :phone, :message => "Phone number can't be blank"
    validates_presence_of :nationality, :message => "Nationality can't be blank"
    validates_presence_of :sex,  :message => "Sex must be selected"
    validates_presence_of :university,  :message => "University can't be blank"
    validates_presence_of :field_of_study,  
		:message => "Field of study can't be blank"
    validates_presence_of :workshop1,  :message => "Workshop 1 not selected"
    validates_presence_of :workshop2,  :message => "Workshop 2 not selected"
   # validates_presence_of :essay1, :message => "Essay 1 can't be blank"
   # validates_presence_of :essay2, :message => "Essay 2 can't be blank"
    validates_presence_of :birthdate, :message => "Date of birth not valid"

    #Validate WSs
   # validates_numericality_of :workshop1,:greater_than => 0, 
   #		:message => "Workshop 1 not selected"
   # validates_numericality_of :workshop2,:greater_than => 0, 
   #		:message => "Workshop 2 not selected"


    #Validate Email
    validates_format_of :email,
                :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                :message => 'Email must be valid'
    validates_uniqueness_of :email, 
		:message => "An application with this email 
					address has already been registered"

    #Validate Self defined
    validate :check_age

    # Validate travel support
    validates_presence_of :travel_essay,
            :if => Proc.new { |n| n.travel_apply > 0 },
            :message => "Travel Essay can't be blank "
    validates_presence_of :travel_amount,
            :if => Proc.new { |n| n.travel_apply > 0 },
            :message => "Travel amount can't be blank"
    validates_numericality_of :travel_amount,
            :if => Proc.new { |n| n.travel_apply > 0 },
            :message => "Travel amount must be a number"

    def check_age
      errors.add_to_base("Age should be between 18 and 100") unless birthdate != nil and
                Date.today.year - birthdate.year < 101 && (
                     2009 - birthdate.year > 18 or
                    (2009 - birthdate.year == 18 && birthdate.month == 1)  or
                    (2009 - birthdate.year == 18 && birthdate.month == 2 && birthdate.day < 21))

    end

    def region
      @region
    end
    
    def region=(value)
      @region=value
    end
    
    # Number of attending participants
    def self.attending
      connection.select_one("SELECT COUNT(*) as C FROM participants p, answers a WHERE p.id = a.id AND a.attend = 1 AND arrival_date IS NOT NULL")['C']      
    end
    
    # Returns number of participants that have checked in
    def self.checked_in
      connection.select_one("SELECT COUNT(*) as C FROM participants p, answers a WHERE p.checked_in IS NOT NULL AND p.id = a.id AND a.attend = 1 AND arrival_date IS NOT NULL")['C']
    end
    
    # Returns number of participants that have checked in but is not assigned to any host
    def self.checked_in_host
      connection.select_one("SELECT COUNT(*) as C FROM participants p, answers a WHERE checked_in IS NOT NULL AND host_id IS NOT NULL AND p.id = a.id AND a.attend = 1 AND arrival_date IS NOT NULL")['C']      
    end    
    
    # Returns number of participants that have checked in and is assigned to a host
    def self.checked_in_no_host
      connection.select_one("SELECT COUNT(*) as C FROM participants p, answers a WHERE checked_in IS NOT NULL AND host_id IS NULL AND p.id = a.id AND a.attend = 1 AND arrival_date IS NOT NULL")['C']      
    end
          
    # Returns number of participants that is gluten intolerant
    def self.participants_gluten
      connection.select_one("SELECT COUNT(p.id) as C FROM participants p, answers a WHERE checked_in IS NOT NULL AND p.id = a.id AND a.gluten = 1")['C']      
    end     
         
    # Returns number of participants that is lactose intolerant
    def self.participants_lactose
      connection.select_one("SELECT COUNT(p.id) as C FROM participants p, answers a WHERE checked_in IS NOT NULL AND p.id = a.id AND a.lactose = 1")['C']      
    end      
       
    # Returns number of participants that is lactose intolerant
    def self.participants_vegetarian
      connection.select_one("SELECT COUNT(p.id) as C FROM participants p, answers a WHERE checked_in IS NOT NULL AND p.id = a.id AND a.vegetarian = 1")['C']      
    end      
     
    # Returns number of participants that is halal
    def self.participants_halal
      connection.select_one("SELECT COUNT(p.id) as C FROM participants p, answers a WHERE checked_in IS NOT NULL AND p.id = a.id AND a.halal = 1")['C']      
    end     
    
    # Returns number of participants that is kosher
    def self.participants_kosher
      connection.select_one("SELECT COUNT(p.id) as C FROM participants p, answers a WHERE checked_in IS NOT NULL AND p.id = a.id AND a.kosher = 1")['C']      
    end
      
    # Returns number of participants that have been picked up by a host
    def self.picked_up
      connection.select_one("SELECT COUNT(*) as C FROM participants p WHERE picked_up IS NOT NULL")['C']      
    end
    
    # Returns number of participants that have not checked in and is assigned to a host
    def self.not_checked_in_host
      connection.select_one("SELECT COUNT(*) as C FROM participants p, answers a WHERE checked_in IS NULL AND host_id IS NOT NULL AND p.id = a.id AND a.attend = 1 AND arrival_date IS NOT NULL")['C']            
    end   
    
    # Returns number of participants that have not checked in but is not assigned to any host
    def self.not_checked_in_no_host
      connection.select_one("SELECT COUNT(*) as C FROM participants p, answers a WHERE checked_in IS NULL AND host_id IS NULL AND p.id = a.id AND a.attend = 1 AND arrival_date IS NOT NULL")['C']            
    end

	def self.count_beds
	  connection.select_one("SELECT COUNT(*) AS beds FROM participants WHERE bed>0")["beds"].to_i
	end
	
	def self.count_beddings
	  connection.select_one("SELECT COUNT(*) AS beddings FROM participants WHERE bedding=1")["beddings"].to_i
	end
	
	def self.count_beds_first
	  connection.select_one("SELECT COUNT(*) AS beds FROM participants WHERE bed=1")["beds"].to_i
	end
	
	def self.count_beds_second
	  connection.select_one("SELECT COUNT(*) AS beds FROM participants WHERE bed>1")["beds"].to_i
	end
end
