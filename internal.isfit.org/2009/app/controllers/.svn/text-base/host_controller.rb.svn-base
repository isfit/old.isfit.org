class HostController < ApplicationController

  helper :sort
	include SortHelper


	def index
		redirect_to :action => "apply"
	end
	
	def mail_hosts
	  
	end
	
	def send_mail

	end
	
	def statistics
	  # Number of hosts
		@hosts = Host.count(:all)
		
		# Number of hosts with preferences
		@hosts_with_preferences = Host.hosts_with_preferences.size
		
		# Total number of beds
		@beds = Host.total_number_of_beds
		
    # Total number of free beds
		@free_beds = Host.number_of_free_beds
		
    # Number of participants
		@participants = Participant.attending
		
    # Number of checked in participants
		@checked_in = Participant.checked_in
		
    # Number of checked in participants with host assigned
		@checked_in_host = Participant.checked_in_host
		
    # Number of checked in participants without host assigned
		@checked_in_no_host = Participant.checked_in_no_host

    # Number of picked up participants
		@picked_up = Participant.picked_up

    # Number of participants not checked in, but with host assigned
		@not_checked_in_host = Participant.not_checked_in_host

    # Number of participants not checked and without host assigned
		@not_checked_in_no_host = Participant.not_checked_in_no_host
		
		# FOOD stash
    @vegetarians = Participant.participants_vegetarian
    @lactoses = Participant.participants_lactose
    @glutens = Participant.participants_gluten
    @koshers = Participant.participants_kosher
    @halals = Participant.participants_halal

	end
	
	def apply
		if params[:host]
			@host = Host.new(params[:host])
			if @host.save
				redirect_to :action => "done"
			else
				flash[:warnings] = @host.errors
			end
		end	
	end
	
	def view
	 @host = Host.find_by_id(params[:id])

	 if request.post?
			@host.attributes = params[:host]
			@host.save
			redirect_to :action => :list
	 end
	end
	
	def list_all_hosts
	  @hosts = Host.find(:all)
	end
	
	def done
		
	end
	
	def list
	  sort_init 'hosts.id'
  	sort_update
	  @not_matched = false
	  @free_beds = false
	  @nof_free_beds = Host.number_of_free_beds
	  @nof_total_beds = Host.total_number_of_beds
	  @hosts = Host.paginate(:all, :page => params[:page], :order => sort_clause,:per_page => 20)
	end
	
	def browse
  	  sort_init 'hosts.id'
    	sort_update
    	
    	sc = params[:search_criteria]
    	@not_matched = false
    	@free_beds = false
    	if params[:not_matched]
    	  @not_matched = true
    	end
    	if params[:free_beds]
    	 @free_beds = true
    	end
    	if sc == ''
    	  @hosts = Host.paginate(:all, :page => params[:page], :order => sort_clause,:per_page => 50)
  	  else
    	  query = " hosts.first_name LIKE '%#{sc}%' OR hosts.last_name LIKE '%#{sc}%' OR hosts.email LIKE '%#{sc}%'"
  	    @hosts = Host.paginate(:page => params[:page], :order => sort_clause,:per_page => 50, 
  	                              :conditions => "#{query}")
	    end
  	 	render(:template => 'host/list')
	end
	
	def make_match
	 
	 @participants_not_matched = []
	 if request.post?
	   matches = params[:selected_participants]
	   
   	 host_id = params[:host_id]
     host = Host.find(host_id)
     
     host.remove_unchecked(matches)
     
     if matches != nil && matches.size > 0
      for match in matches
     	  Participant.transaction do
   	      p = Participant.find(match)
          
          # Check if the participant already has a host (not this host)
     	    if p.host_id != nil && p.host_id != host_id
     	        
     	        # Log which participants that could not be matched
     	        @participants_not_matched.push(p.id)
     	      
     	      break
     	    else
     	      # Host id is not set or this host already have it.
     	      p.host_id = host_id
     	      p.save
     	    end
     	 end
     	end
    end	   
	 end
	     
	 redirect_to :action => 'match', :id => host_id, :participants_not_matched => @participants_not_matched
	end
	def match

	 if params[:id]
	   @host = Host.find_by_id(params[:id])
	 end
	 if params[:participants_not_matched]
	    @participants_not_matched = params[:participants_not_matched].collect do |p| Participant.find(p) end
	 end
   if request.post?
	   search = ""
  	 if params[:male]
  	    search = "sex ='m'"
  	 end
  	 if params[:female]
  	    search = (search.size > 0 ? "(sex = 'm' OR sex = 'f')" : "sex = 'f'")
  	 end
     if params[:search_criteria]
       search += (search.size > 0 ? " AND (" : "(") + "
                                        participants.id = #{params[:search_criteria].to_i}
                                      OR first_name  LIKE '%#{params[:search_criteria]}%' 
                                      OR last_name  LIKE '%#{params[:search_criteria]}%' 
                                      OR middle_name  LIKE '%#{params[:search_criteria]}%'
                                      OR city  LIKE '%#{params[:search_criteria]}%'
                                      OR (countries.name  LIKE '%#{params[:search_criteria]}%' AND countries.id = participants.country_id)
                                      )"
     end
  	 if params[:smoke]
  	    search += (search.size > 0 ? " AND smoke = 1" : "smoke = 1")
  	 end
  	 if params[:vegetarian]
  	   search += (search.size > 0 ? " AND vegetarian = 1" : "vegetarian = 1")
  	 end
  	 if params[:lactose]
  	   search += (search.size > 0 ? " AND lactose = 1" : "lactose = 1")
  	 end
  	 if params[:gluten]
  	   search += (search.size > 0 ? " AND gluten = 1" : "gluten = 1")
  	 end
  	 if params[:kosher]
  	   search += (search.size > 0 ? " AND kosher = 1" : "kosher = 1")
  	 end
  	 if params[:halal]
  	   search += (search.size > 0 ? " AND halal = 1" : "halal = 1")
  	 end  	 
  	 
  	 if params[:stay_with]
  	   if params[:stay_with] != ""
  	     opt = 'NO_MATTER'
    	   if params[:stay_with] == "Male"
    	     opt = "MALE"
    	   elsif params[:stay_with] == "Female"
    	     opt = "FEMALE"
    	   end
    	   search += (search.size > 0 ? " AND answers.stay_with = '#{opt}'" : "answers.stay_with = '#{opt}'")  
  	   end
  	   
  	 end  	 
  	 if params[:visa]
  	   search += (search.size > 0 ? " AND (answers.visa = 'NO_NEED_OF_VISA' or answers.visa = 'VISA_BEEN_GRANTED')" : "(answers.visa = 'NO_NEED_OF_VISA' or answers.visa = 'VISA_BEEN_GRANTED')")
  	 end
  	 if search.size > 0
  	   @query = " (" + search + ") AND participants.id = answers.id AND answers.attend = 1"
  	 else
  	   @query = "participants.id = answers.id AND answers.attend = 1"
  	 end
  	 @query += params[:not_checked_in] ? "" : " AND participants.checked_in IS NOT NULL AND participants.host_id IS NULL OR participants.host_id = #{@host.id}"

     @participants = Participant.paginate(:all, :order => "host_id desc", :include => [:answer, :country], :page => params[:page], :per_page => 50, :conditions => "#{@query} AND participants.host_id IS NULL OR participants.host_id = #{@host.id} AND arrival_date IS NOT NULL")
   else
     @participants = Participant.paginate(:all,  :order => "host_id desc", :include => :answer, :page => params[:page], :per_page => 50, :conditions => "participants.id = answers.id AND answers.attend = 1 AND participants.checked_in IS NOT NULL AND participants.host_id IS NULL OR participants.host_id = #{@host.id} AND arrival_date IS NOT NULL")
     
   end
   @assigned_participants = Participant.find(:all, :conditions => "host_id = #{@host.id}")
	end
	
	def delete
	 host = Host.find_by_id(params[:id])
	 
	 #Find participants linked to this host
	 participants = host.get_assigned_participants
	 for p in participants
	   # Delete all traces of this host
	   p.host_id = nil
	   p.picked_up = nil
	   p.save
	 end	 

	 #Finally delete host
	 host.destroy
	 redirect_to :action => "list" 
	end
	
end
