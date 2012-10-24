class Event < ActiveRecord::Base
  belongs_to :event_type
  has_many :event_dates
  belongs_to :event_place

  has_attached_file :promo, 
    path: ":rails_root/public/system/frontend_articles/:attachment/:id_partition/:style/:filename",
    url: "/system/frontend_articles/:attachment/:id_partition/:style/:filename",
    :styles => { :large => "940x480>"}
end
