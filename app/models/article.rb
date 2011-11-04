class Article < ActiveRecord::Base
  set_primary_key 'id'
  lang_attr :title, :ingress, :body, :sub_title

  has_attached_file :frontend_article_image, styles:  {
    front_large: {geometry: "530x196#", processors: [:cropper] },
    front_small: {geometry: "250x120#", processors: [:cropper_half] },
    article: {geometry: "447x346#", processors: [:cropper_spp_one_third] }
  }

end
