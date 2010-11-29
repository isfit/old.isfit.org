require 'ldap_access_list'
require 'paperclip'

class ApplicationController < ActionController::Base
  class Helper
    include ActionView::Helpers::DateHelper
    include ActionView::Helpers::PrototypeHelper     
  end  
	helper :all # include all helpers, all the time

	# See ActionController::RequestForgeryProtection for details
	# Uncomment the :secret if you're not using the cookie session store
	protect_from_forgery # :secret => '9c2c4d1aaa24a8cc79772a99a69a0853'

	before_filter :authenticate, :authorize, :setup
	helper_method :logged_in?, :current_user, :current_user=
	after_filter :free_ldap

	def free_ldap
		if LdapRecord.bound?
			LdapRecord.unbind
		end
	end

	def logged_in?
		!@current_user.nil?
	end

	def current_user
		@current_user
	end

	def current_user=(value)
		@current_user = value
	end

	private

	# Make sure the user is authenticated
	def authenticate
		if not session[:user]
			if request.post? 
				if params[:username].match(/^[a-z0-9\-_]+$/i) and
				user = LdapAccessList.authenticate('internal11', 'everyone',  
				params[:username], params[:password])
					initialize_session(user)
					flash[:warning] = nil

					if not session[:profile_checked] == true
						# Make sure user has a complete profile, or else send to
						# edit profile page
						@current_user = LdapUser.get_by_dn(session[:user])
						session[:profile_checked] = true
						unless Functionary.has_complete_info?(current_user.id)
							flash[:warning] = "Your profile information is incomplete, please
								fill out all fields marked with an asterisk (*) as well as
								your Samfundet and NTNU card number, and whether or not you
								already have an internal Samfundet card (gjengkort)"
							redirect_to :controller => :user, :action => :edit	
						end
					else
						redirect_to :action => action_name
					end
				else
					flash[:warning] = "Looks like that's not right. " +
						"Give it another go?"
					flash[:custom] = true
				end
			end
		end

		# If user is not yet authenticated, render login form
		if (session[:time] and (Time.now - session[:time] > 3600) or not session[:user])
			reset_session
			render(:template => "login/index")
		else
			session[:time] = Time.now
		end
	end

	def can_access?(controller, action)
		request_action = {:controller => controller, :action => action}
		request_controller = {:controller => controller, :action => '*'}
		all = {:controller => '*', :action => '*'}

		session[:access].include?(request_action) or 
			session[:access].include?(request_controller) or
			session[:access].include?(all)
	end

	# Authorizes the loading of the requested action
	def authorize
		unless can_access?(controller_name, action_name)
			render(:template => "login/unauthorized")
		end
	end

	# Prepares for the application to be rendered
	def setup
		# Fetch the currently logged in user
		@current_user = LdapUser.get_by_dn(session[:user])

		# Make the menu available to views
		@menu = build_menu

		# Determine the current active tab
		@menu[:tab] = nil
		@menu[:tabs].each do |tab|
			if tab[:title].downcase == params[:tab]
				@menu[:tab] = tab
				break
			end
		end
		
		setup_calendar
	end

  def setup_calendar
		
		session[:calendar_year] = DateTime.now.year unless session[:calendar_year]
		session[:calendar_month] = DateTime.now.month unless session[:calendar_month]
		
		session[:calendar_month] = params[:month].to_i if params[:month]
		session[:calendar_year] = params[:year].to_i if params[:year]

		if session[:calendar_month] == 0
		  session[:calendar_month] = 12
		  session[:calendar_year] -= 1
		elsif session[:calendar_month] == 13
		  session[:calendar_month] = 1
		  session[:calendar_year] += 1
	  end
	  get_events = CalendarEvent.find(:all, :conditions => "`deleted` = 0", :order => 'start')
    @days = ApplicationController.get_days(get_events, session[:calendar_month],session[:calendar_year],current_user)
    @upcoming_events = ApplicationController.get_upcoming_events(get_events,current_user)
	end

	# Initializes the session for the given user
	def initialize_session(user)
		# Store user LDAP DN
		session[:user] = user.dn

		# Store user access list
		session[:access] = LdapAccessList.get_user_access('internal11', user)

    # Session start time
		session[:time] = Time.now
	end

	# Builds a hash containing all menu tabs, link groups and links 
	# accessible by the logged in user.
	def build_menu
  
	  
		@menu = {:tab => nil, :tabs => []}
		
		# Iterate all menu tabs
		MenuTab.find(:all).each do |menu_tab|
			tab = {:title => menu_tab.title, :groups => []}

			# Iterate all menu tab link groups
			menu_tab.menu_link_groups.each do |menu_link_group|
				group = {:title => menu_link_group.title, :links => []}
				
				# Iterate all link group links
				menu_link_group.menu_links.each do |menu_link|
					# Check if the menu link target is accessible
					if can_access?(menu_link.controller, menu_link.action)
						# Add the menu link to the menu link group
						group[:links].push({:title => menu_link.title,
							:controller => menu_link.controller, :action =>
							menu_link.action})
					end
				end

				# Check for presence of links in the menu link group
				unless group[:links].empty?
					# Add menu link group to menu tab
					tab[:groups].push(group)
				end
			end

			# Check for presence of menu link groups in the menu tab
			unless tab[:groups].empty?
				# Add menu tab to list of menu tabs
				@menu[:tabs].push(tab)
			end
		end

		@menu
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
  
  def self.get_upcoming_events(events,current_user)
    count = 1
    todays_date = Date.today
    upcoming = []
    events.each do |event|
      if CalendarEventController.has_access?(event, current_user)
        #if event.start.strftime("%Y-%b-%d").to_date >= todays_date
        if ApplicationController.compare_dates(todays_date , event.start.strftime("%Y-%b-%d").to_date)
          upcoming.push(event)
          if count == 5
            #break
          end
          count +=1
        end
       end      
    end
    upcoming
  end

  def self.compare_dates(d1,d2)
    #returns true if d2 is greater than or equal to d1
    if d2.year == d1.year
      if d2.mon == d1.mon
        if d2.day >= d1.day
          return true
        end
      elsif d2.mon > d1.mon
        return true
      end
    elsif d2.year > d1.year
      return true
    end
    return false    
  end

end
