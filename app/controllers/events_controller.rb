class EventsController < ApplicationController
  def index
    @categories = EventType.all
    if not params[:category]
      @events = Event.where(:visible => 1)
    else
      @category = EventType.where(:id => params[:category]).first
      @events = @category.events
    end

  end

  def show
    @event = Event.find(params[:id])
  end

end
