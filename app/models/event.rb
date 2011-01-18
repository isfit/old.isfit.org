class Event < ActiveRecord::Base
  belongs_to :event_type
  has_many :event_dates
  belongs_to :event_place
  has_attached_file :image,
  :path =>":rails_root/public/images/:class/:attachment/:id/:style.:extension", 
  :url => ":class/:attachment/:id/:style.:extension",
  :styles => {:thumb=> "200x200#", :original =>"700x700>"},
  :default_url=> "/images/missing.png"

end
