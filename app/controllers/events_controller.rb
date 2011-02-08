class EventsController < ApplicationController
  
  
  def index
   now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @categories = EventType.all
    if params[:category]
      @category = EventType.where(:id => params[:category]).first
      if params[:year] && params[:month] && params[:day]
        @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
        @event_dates = @category.event_dates.joins(:event).where("event_dates.date LIKE '"+@date.to_s+"%' AND events.visible_at <= '"+now+"' AND events.deleted <> 1 AND events.isfit = 1")
      else
        @event_dates = @category.event_dates.where("events.visible_at <= '"+now+"' AND events.deleted <> 1 AND event_dates.date > '"+now+"' AND events.isfit = 1").order("event_dates.date")
      end
    elsif params[:year] && params[:month] && params[:day]
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      @event_dates = EventDate.joins(:event).where("event_dates.date LIKE '"+@date.to_s+"%' AND events.visible_at <= '"+now+"' AND events.deleted <> 1 AND events.isfit = 1")
    else
      @event_dates = EventDate.joins(:event).where("events.visible_at <= '"+now+"' AND events.deleted <> 1 AND event_dates.date > '"+now+"' AND events.isfit = 1").order("event_dates.date")
    end
    @event_dates = @event_dates.order(:date)
    respond_to do |format|
      format.html
      @events = Event.where("events.visible_at <= '"+now+"' AND events.deleted <> 1 AND events.isfit = 1")
      @events.each do |e|
        e.description = e.description.gsub(/[\*]*/,'') 
      end
      format.xml { render :xml => @events.to_xml(:include=>[:event_dates,:event_place,:event_type])}
      format.json { render :json => @events.to_xml(:include=>[:event_dates,:event_place,:event_type])}
   end

  end
  def search
    @categories = EventType.all
    @event_dates = EventDate.joins(:event).where("events.title LIKE ?", "%"+params[:event][:search]+"%")
    respond_to do |format|
      format.js
      format.html { render :index}
    end
  end
  def show
    now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    if params[:event_date_id]
      @event = EventDate.joins(:event).where(:id=>params[:event_date_id]).where("events.visible_at <= '"+now+"' AND events.deleted <> 1 AND events.isfit = 1").first
    elsif
      @event = EventDate.joins(:event).where("events.id = "+params[:id]+" AND events.visible_at <= '"+now+"' AND events.deleted <> 1 AND events.isfit = 1").first
    end
  
    respond_to do |format|
      format.html
      @event_no_html = @event.clone
      @event_no_html.event.description = @event_no_html.event.description.gsub(/[\*]*/,'') 
      format.xml { render :xml => @event_no_html.event.to_xml(:include=>[:event_dates,:event_place,:event_type])}
      format.json { render :json => @event_no_html.event.to_json(:include => :event_dates, :include=>:event_place, :include=>:event_type) }
    end         
  end
end
