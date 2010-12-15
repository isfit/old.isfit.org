class SppArticle < ActiveRecord::Base

  validates_presence_of :title_en, :message => "Article title is missing!"
  validates_presence_of :body_en, :message => "Article is missing!"
end
