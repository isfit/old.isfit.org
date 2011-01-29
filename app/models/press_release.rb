class PressRelease < ActiveRecord::Base
 has_attached_file :attachment, :path =>":rails_root/public/files/pr/:class/:attachment/:id/:style.:extension", 
                                  :url => "files/pr/:class/:attachment/:id/:style.:extension"

end
