class Article < ActiveRecord::Base
  set_primary_key 'id'
  lang_attr :title, :ingress, :body, :sub_title

  has_attached_file :frontend_article_image, styles:  {
    frontpage_large: {geometry: "620x362#", processors: [:cropper] },
    article_large: {geometry: "940x480#", processors: [:cropper_half] }
  },
  url: "/system/frontend_articles/:attachment/:id_partition/:style/:filename",
  path: ":rails_root/public/system/frontend_articles/:attachment/:id_partition/:style/:filename"


end
