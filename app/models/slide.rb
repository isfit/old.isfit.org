class Slide < ActiveRecord::Base
has_attached_file :image, :path =>":rails_root/public/images/slide/:class/:attachment/:id/:style.:extension", 
                                  :url => "slide/:class/:attachment/:id/:style.:extension"

end
