class EventsController < ApplicationController
  def index
   now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @categories = EventType.all
    if params[:category]
      @category = EventType.where(:id => params[:category]).first
      if params[:year] && params[:month] && params[:day]
        @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
        @events = @category.events.joins(:event_dates).all(:conditions=>"visible=1 AND event_dates.date LIKE '"+@date.to_s+"%' AND visible_at <= '"+now+"'")
      else
        @events = @category.events.where(:visible => 1).where("visible_at <= '"+now+"'")
      end
    elsif params[:year] && params[:month] && params[:day]
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      @events = Event.joins(:event_dates).all(:conditions=>"visible=1 AND event_dates.date LIKE '"+@date.to_s+"%' AND visible_at <= '"+now+"'")
    else
      @events = Event.where(:visible => 1).where("visible_at <= '"+now+"'")
    end

  end

  def show
    @event = Event.find(params[:id]).where("visible_at <= '"+now+"'").where(:visible => 1)
  end

end
