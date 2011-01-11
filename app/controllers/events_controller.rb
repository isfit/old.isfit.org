class EventsController < ApplicationController
  def index
   now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @categories = EventType.all
    if params[:category]
      @category = EventType.where(:id => params[:category]).first
      if params[:year] && params[:month] && params[:day]
        @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
        @event_dates = @category.event_dates.joins(:event).all(:conditions=>"events.visible=1 AND event_dates.date LIKE '"+@date.to_s+"%' AND events.visible_at <= '"+now+"'")
      else
        @event_dates = @category.event_dates.where("events.visible = 1").where("events.visible_at <= '"+now+"'")
      end
    elsif params[:year] && params[:month] && params[:day]
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      @event_dates = EventDate.joins(:event).all(:conditions=>"events.visible=1 AND event_dates.date LIKE '"+@date.to_s+"%' AND events.visible_at <= '"+now+"'")
    else
      @event_dates = EventDate.joins(:event).where("events.visible = 1").where("events.visible_at <= '"+now+"'")
    end
  end

  def show
    now = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    @event = EventDate.joins(:event).where(:id=>params[:event_date_id]).where("events.visible_at <= '"+now+"'").where("events.visible = 1").first
  end

end
