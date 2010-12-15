class AddBylineToFrontendArticle < ActiveRecord::Migration
  def self.up
    add_column :frontend_articles, :byline, :string
  end

  def self.down
    remove_column :frontend_articles, :byline
  end
end
