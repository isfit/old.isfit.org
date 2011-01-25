class CreateEventPlaces < ActiveRecord::Migration
  def self.up
    create_table :event_places do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :event_places
  end
end
