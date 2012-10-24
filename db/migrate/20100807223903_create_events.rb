class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.integer :event_type_id
      t.date :date
      t.integer :price_member
      t.integer :price_other
      t.text :ingress
      t.text :description
      t.integer :related_evend_id
      t.boolean :deleted
      t.boolean :important
      t.boolean :visible
      t.string :ticket_url
      t.string :spotify
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
