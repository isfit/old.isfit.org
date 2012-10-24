class AddFacebookEventIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :facebook_event_id, :string

  end
end
