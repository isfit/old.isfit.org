class Host < ActiveRecord::Base
  has_many :participants
  
	#Validate parameters
	validates_presence_of :first_name, :message => "First name can't be blank"
	validates_presence_of :last_name, :message => "Last name can't be blank"
	validates_presence_of :address, :message => "Address can't be blank"
	validates_presence_of :zipcode, :message => "ZIP code can't be blank"
	validates_presence_of :place, :message => "City can't be blank"
	validates_presence_of :phone, :message => "Phone number can't be blank"
	validates_presence_of :age, :message => "Your age is not valid"
	validates_presence_of :number, :message => "Number of visitors can't be empty"
	
	#Validate Email
	validates_format_of :email,
		:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
		:message => 'Email must be valid'
	validates_uniqueness_of :email, 
		:message => "An application with this email 
				address has already been registered"

  def name
    self.first_name + " " + self.last_name
  end
  
  def get_assigned_participants
    Participant.find(:all, :include => :host, :conditions => "participants.host_id = #{self.id}")
  end
  
  def remove_unchecked(checked_participant_ids)
    
    # Find all assigned participants
    assigned_participants = Participant.find(:all, :conditions => "participants.host_id = #{self.id}")
    
    for participant in assigned_participants
      if checked_participant_ids == nil or !checked_participant_ids.include?(participant.id)
        participant.host_id = nil
        participant.picked_up = nil
        participant.save
      end
    end
  end

  # If all participants matched with this host is picked up
  def pickup_complete?
    Participant.find(:all, :conditions => "host_id = #{self.id} AND picked_up IS NULL").size==0
  end
  
  # If the host have any participants matched to it
  def matched?
    Participant.find(:all, :conditions => "host_id = #{self.id}").size>0
  end
  
  # Returns participants picked up by this host
  def picked_up_participants
    Participant.find(:all, :conditions => "host_id = #{self.id} and picked_up IS NOT NULL")
  end
  
  # Returns participants matched with this host
  def matched_participants
    Participant.find(:all, :conditions => "host_id = #{self.id}")
  end
  

  
  # Returns true/false wether the host have free beds
  def free_beds?
    (self.number - self.matched_participants.size) > 0
  end
  
  # Static method: Returns the total number of free beds
  def self.number_of_free_beds
    self.total_number_of_beds.to_i - connection.select_one("SELECT COUNT(*) as C FROM participants WHERE host_id IS NOT NULL")['C'].to_i
  end
  
  # Static method: Returns the total number of beds
  def self.total_number_of_beds
    connection.select_one("SELECT SUM(number) FROM hosts")['SUM(number)']
  end
  
  # Returns the number of hosts with preferences specified
  def self.hosts_with_preferences
    connection.select_one("SELECT COUNT(*) as C FROM hosts WHERE preference = ''")['C']    
  end

end