class Workshop < ActiveRecord::Base
  #lang_attr :title, :ingress, :body, :sub_title

  attr_accessor :image_file_name, :image_content_type, :image_file_size, :image_updated_at

  has_attached_file :workshop_image, :styles => { :original => "250x530>",
                                                  :thumb => "120x230>"}

end
