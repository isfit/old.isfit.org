class Event < ActiveRecord::Base
  belongs_to :event_type
  has_many :event_dates

  has_attached_file :image
end
