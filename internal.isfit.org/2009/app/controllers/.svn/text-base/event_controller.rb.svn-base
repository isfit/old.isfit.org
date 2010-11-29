class EventController < ApplicationController
  helper :sort
  include SortHelper
	
  def list
    sort_init 'date', :default_order => 'desc'
		sort_update
    
    @events = Event.paginate(:page => params[:page], :order => sort_clause, :conditions => "deleted = 0", :per_page => 20)
  end

  def create
    CalendarDateSelect.format = :iso_date
    
    if request.post?
			extra = []
      if params[:id]
        @event = Event.find(params[:id], :conditions => "deleted = 0")
        @event.attributes = params[:event]
      else
				# Extract additional dates and times
				(1..9).each do |n|
					if params[:event]["extra_date_#{n}"] != ""
						extra.push(DateTime.strptime(params[:event]["extra_date_#{n}"],
							"%Y-%m-%d %H:%M"))
					end
					params[:event].delete("extra_date_#{n}")
				end
        # Fetch the posted parameters and create a new event object.
        @event = Event.new(params[:event])
      end      
      if @event.save
        unless params[:image] == ""
  				path = "#{RAILS_ROOT}/public/images/programme_images/" +
  					"#{@event.id}.jpg"
  				@picture = Picture.new(path, params[:image],400)
  				@picture.save
  		end
				extra.each do |d|
					event = Event.new(params[:event])
					event.date = d
					event.save
				end
        redirect_to :action => "list"
      else
        flash[:warnings] = @event.errors
        #Do something
      end
    else
      if params[:id]
        @event = Event.find(params[:id], :conditions => "deleted = 0")
      end
    end
  end
  
  def delete
    event = Event.find(params[:id])
    event.deleted = 1
    event.save
    redirect_to :action => "list"
  end

end
