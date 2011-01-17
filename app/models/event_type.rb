class EventType < ActiveRecord::Base
  has_many :events
  has_many :event_dates, :through=>:events
end
