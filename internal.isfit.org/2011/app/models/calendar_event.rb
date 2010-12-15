class CalendarEvent < ActiveRecord::Base
  validates_presence_of :title, :message => "Event needs title"
  validates_presence_of :body, :message => "Event needs text"
  validates_presence_of :start, :message => "Event needs start time"
  validates_presence_of :stop, :message => "Event needs end time"
  
end
