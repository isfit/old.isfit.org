class CreateSppArticles < ActiveRecord::Migration
  def self.up
    create_table :spp_articles do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :spp_articles
  end
end
