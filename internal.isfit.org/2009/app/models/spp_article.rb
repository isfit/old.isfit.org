class SppArticle < ActiveRecord::Base

  validates_presence_of :title, :message => "Article title is missing!"
  validates_presence_of :body, :message => "Article is missing!"
end
