class EventsController < ApplicationController
  
  
  def index
   now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @categories = EventType.all
    if params[:category]
      @category = EventType.where(:id => params[:category]).first
      if params[:year] && params[:month] && params[:day]
        @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
        @event_dates = @category.event_dates.joins(:event).where("event_dates.date LIKE '"+@date.to_s+"%' AND events.visible_at <= '"+now+"'")
      else
        @event_dates = @category.event_dates.where("events.visible_at <= '"+now+"'").order("event_dates.date")
      end
    elsif params[:year] && params[:month] && params[:day]
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      @event_dates = EventDate.joins(:event).where("event_dates.date LIKE '"+@date.to_s+"%' AND events.visible_at <= '"+now+"'")
    else
      @event_dates = EventDate.joins(:event).where("events.visible_at <= '"+now+"'").order("event_dates.date")
    end
    @event_dates = @event_dates.order(:date)
    respond_to do |format|
      format.html
      format.xml { render :xml => Event.where("events.visible_at <= '"+now+"'").to_xml(:include => :event_dates, :include=>:event_place) }
      format.json { render :json => Event.where("events.visible_at <= '"+now+"'").to_json(:include => :event_dates, :include=>:event_place) }
    end

  end

  def show
    now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    if params[:event_date_id]
      @event = EventDate.joins(:event).where(:id=>params[:event_date_id]).where("events.visible_at <= '"+now+"'").first
    elsif
      @event = EventDate.joins(:event).where("events.id = "+params[:id]+" AND events.visible_at <= '"+now+"'").first
    end
  
    respond_to do |format|
      format.html
      format.xml { render :xml => @event.event.to_xml(:include => :event_dates, :include=>:event_place) }
      format.json { render :xml => @event.event.to_json(:include => :event_dates, :include=>:event_place) }
    end         
  end
end
