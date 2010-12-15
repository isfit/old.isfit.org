class Event < ActiveRecord::Base
  validates_presence_of :title, :message => "Hey you! You forgot a title."
  validates_presence_of :date, :message => "You forgot to select date/time for the event."
  validates_presence_of :place, :message => "The event has no place"
  validates_presence_of :price_member, :message => "You forgot to specify a member price. Free is written as '0' "
  validates_presence_of :price_member, :message => "You forgot to specify a price for other. Free is written as '0' "
  validates_presence_of :description, :message => "Event needs description"
end