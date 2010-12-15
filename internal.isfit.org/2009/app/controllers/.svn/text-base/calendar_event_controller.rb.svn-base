class CalendarEventController < ApplicationController
  include ActionView::Helpers::PrototypeHelper 
  include ActionView::Helpers::ScriptaculousHelper
  $rsvp_options = {'Will attend' => 1, 'Will not attend' => 2, 'Maybe' => 3}
  $rsvp_text = ['Will attend', 'Will not attend', 'Maybe', 'Not replied yet']
  $test = "hei"
   
  def show
     if params[:id]
        get_events = CalendarEvent.find(:all, :conditions => "`deleted` = 0" )
        
        events = []
        dates = []
        get_events.each do |event|
          if CalendarEventController.has_access?(event, current_user)
             #Generates a list with the dates existing in every event
             dates.push(event.start.strftime("%Y-%b-%d").to_date)
             tempdate = event.start.strftime("%Y-%b-%d").to_date
             until tempdate == event.stop.strftime("%Y-%b-%d").to_date.next
                dates.push(tempdate)
                tempdate = tempdate.next
             end
             #Gets all events for the given date          
             if dates.include?(params[:id].to_date)
                 events.push(event)
             end
             dates = []
          end
          
        end
        @events = events
        
        if request.post?

            c = EventAttendants.find(:first, :conditions => "`event_id` = #{params[:event_id]} AND `user_id` = #{current_user.id}")
            if c != nil
              c.rsvp = params[:response][:rsvp]
            else
              c = EventAttendants.new(params[:response])
              c.user_id = current_user.id
              c.event_id = params[:event_id]
            end
            if c.save
              redirect_to :action => "show"
            end
        end
        
     else
       redirect_to :action => "index"
     end
    
  end
  
  def show_event
    if params[:id] and CalendarEventController.has_access?(CalendarEvent.find(params[:id]), current_user)
      @event = CalendarEvent.find(params[:id])
      
      if request.post?

          c = EventAttendants.find(:first, :conditions => "`event_id` = #{params[:event_id]} AND `user_id` = #{current_user.id}")
          if c != nil
            c.rsvp = params[:response][:rsvp]
          else
            c = EventAttendants.new(params[:response])
            c.user_id = current_user.id
            c.event_id = params[:event_id]
          end
          if c.save
            redirect_to :action => "show_event", :id => params[:event_id]
          end
      end
   
   else
      redirect_to :action => "index"
    end
    
  end
  
  def index
    get_events = CalendarEvent.find(:all, :conditions => "`deleted` = 0", :order => 'start')
    
    get_monthly_events = CalendarEventController.get_current_events(get_events, session[:calendar_month],session[:calendar_year])
    # This method gets all days with something happening in the current month
    @days = CalendarEventController.get_days(get_events, session[:calendar_month],session[:calendar_year],current_user)
    
    events = []
    #Filter out only the one visible for this user
    get_monthly_events.each do |event|

      if CalendarEventController.has_access?(event, current_user)
          events.push(event)
      end
      
    end
    
    @events = events.paginate(:page => params[:page], :per_page => 5)
    
    if request.post?

        c = EventAttendants.find(:first, :conditions => "`event_id` = #{params[:event_id]} AND `user_id` = #{current_user.id}")
        if c != nil
          c.rsvp = params[:response][:rsvp]
        else
          c = EventAttendants.new(params[:response])
          c.user_id = current_user.id
          c.event_id = params[:event_id]
        end
        if c.save
          redirect_to :action => "index"
        end
    end
    
  end
  
  def create
    CalendarDateSelect.format = :iso_date
    @user_units = LdapUnit.get_by_dn("ou=isfit09,ou=units,dc=isfit,dc=org").units      
    @units = []
		@units.push(["Everyone","ou=isfit09,ou=units,dc=isfit,dc=org"])
		@user_units.each do |unit|
			@units.push([unit.description, unit.dn])
			unit.units.each do |subunit|
				@units.push([" -> #{subunit.description}", subunit.dn])
			end
		end
        
 
    
    if request.post?
      if params[:id]
        @event = CalendarEvent.find(params[:id])
        @event.attributes = params[:event]
      else
        # Fetch the posted parameters and create a new article object.
        @event = CalendarEvent.new(params[:event])
        @event.user_id = current_user.id
      end
      
      #Checks if stoptime is after starttime
      if @event.stop.strftime("%Y-%b-%d").to_date < @event.start.strftime("%Y-%b-%d").to_date
         @event.stop = ""
      elsif @event.stop.strftime("%Y-%b-%d").to_date == @event.start.strftime("%Y-%b-%d").to_date
        if @event.stop.hour() < @event.start.hour()
          @event.stop = ""
        elsif @event.stop.hour() == @event.start.hour()
          if @event.stop.min() <= @event.start.min()
            @event.stop = ""
          end
        end
      end
      
          
      if @event.save
        redirect_to :action => "index"
      else
        flash[:warnings] = @event.errors
        #Do something
      end
    else
      if params[:id]
        @event = CalendarEvent.find(params[:id])
      end
    end
    
  end
  
  def delete
    if params[:id]
      event = CalendarEvent.find(params[:id])
      event.deleted = 1
      event.save
    end
    redirect_to :action => "index"
  end
  
  def show_attendants
    if params[:id] and CalendarEventController.has_access?(CalendarEvent.find(params[:id]), current_user)
      @event = CalendarEvent.find(params[:id])
   else
      redirect_to :action => "index"
    end
  end
  
  
  def self.has_access?(event, current_user)
    
    #create an array of the dn values (separted by ldap with ",")
    event_dn = event.group_dn.split(",")
    # find matching ou element at the user's dn-list (i.e. traverse backwards the length of the article dn-list)  
    user_credentials = current_user.dn.split(",")[-(event_dn.length)]

    if event_dn[0] == user_credentials or event.user_id == current_user.id or current_user.is_in_group?(event.group_dn)
        return true
    else
      return false
    end
  end
  
  def self.get_current_events(events, month, year)
    e = []
    # This method returns all events starting or ending in the current month
    events.each do |event|
      if (event.start.strftime("%Y").to_i == year and event.start.strftime("%Y-%b-%d").to_date.mon == month) or (event.stop.strftime("%Y").to_i == year and event.stop.strftime("%Y-%b-%d").to_date.mon == month) 
        e.push(event)
      end 
    end
    return e
  end
  
  def self.get_days(events, month, year,current_user)
    # This method return all days within one month which has an event
    d = []
    dates = []
    events.each do |event|
      if CalendarEventController.has_access?(event, current_user)
         #Generates a list with the dates existing in every event
         dates.push(event.start.strftime("%Y-%b-%d").to_date)
         tempdate = event.start.strftime("%Y-%b-%d").to_date
         until tempdate == event.stop.strftime("%Y-%b-%d").to_date.next
            dates.push(tempdate)
            tempdate = tempdate.next
         end
         
         dates.each do |date|
           if date.year == year and date.mon == month
             if d.include?(date.day)
             else
               d.push(date.day)
             end
           end
         end
      end  
    end
    return d
  end
  
  def self.get_attendants(event_id, status)
    c = EventAttendants.find(:all, :conditions => "`event_id` = #{event_id} and `rsvp` = #{status}")
    users = []
    c.each do |u|
      users.push(u.user_id)      
    end
    users
  end
  
  def self.get_current_RSVP(event_id, user_id)
    c = EventAttendants.find(:first, :conditions => "`event_id` = #{event_id} and `user_id` = #{user_id}")
    if c != nil
      retval = c.rsvp
    else 
      retval = 4
    end
  end

end