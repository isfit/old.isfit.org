class AddAttachmentPromoToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.has_attached_file :promo
    end
  end

  def self.down
    drop_attached_file :events, :promo
  end
end
