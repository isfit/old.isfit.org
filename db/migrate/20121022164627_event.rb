class Event < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.string :title
      t.string :event_type
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

  def down
    drop_table :events
  end
end
