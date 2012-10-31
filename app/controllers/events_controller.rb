class EventsController < ApplicationController 

  def index
    @events = Event.all
  end

  def show
    require 'open-uri'
    require 'json'

    @event = Event.find(params[:id])

    # @token = '111446192243028'
    # url = URI.parse('https://graph.facebook.com/510373698975140')

    # result = open(url)

    # puts '---------'
    # puts result
    # puts '---------'

    #@resultat = resultat

  end
end