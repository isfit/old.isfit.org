class EventsController < ApplicationController
  def index
    @categories = EventType.all
    if params[:category]
      @category = EventType.where(:id => params[:category]).first
      if params[:year] && params[:month] && params[:day]
        @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
        @events = @category.events.joins(:event_dates).all(:conditions=>"visible=1 AND event_dates.date LIKE '"+@date.to_s+"%' AND visible_at >= "+Date.new.to_s)
      else
        @events = @category.events.where(:visible => 1).where("visible_at >= "+Date.new.to_s)
      end
    elsif params[:year] && params[:month] && params[:day]
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      @events = Event.joins(:event_dates).all(:conditions=>"visible=1 AND event_dates.date LIKE '"+@date.to_s+"%' AND visible_at >= "+Date.new.to_s)
    else
      @events = Event.where(:visible => 1).where("visible_at >= "+Date.new.to_s)
    end

  end

  def show
    @event = Event.find(params[:id])
  end

end
