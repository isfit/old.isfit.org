class Article < ActiveRecord::Base
  self.primary_key = 'id'
  lang_attr :title, :ingress, :body, :sub_title

  has_attached_file :frontend_article_image, styles:  {
    frontpage_large: {geometry: "620x362#", processors: [:cropper] },
    article_large: {geometry: "940x480#", processors: [:cropper_half] }
  },
  url: "/system/frontend_articles/:attachment/:id_partition/:style/:filename",
  path: ":rails_root/public/system/frontend_articles/:attachment/:id_partition/:style/:filename"

   def self.frontpage_articles language
		articles = Article
			.where("(show_article <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' OR show_article IS NULL)")
			.where(deleted: 0)
			.where(list: 1)

    if language.eql? "en"
      articles = articles.where("title_en > ''")
    else
      articles = articles.where("title_no > ''")
    end

    @articles = articles.order("weight DESC").limit(4)
  end
end
