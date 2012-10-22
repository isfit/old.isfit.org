class EventsController < ApplicationController
  def index
    @events = IsfitEvent.all
  end

  def show
    @event = IsfitEvent.find(params[:id])
  end
end