class CreateSppPages < ActiveRecord::Migration
  def self.up
    create_table :spp_pages do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :spp_pages
  end
end
