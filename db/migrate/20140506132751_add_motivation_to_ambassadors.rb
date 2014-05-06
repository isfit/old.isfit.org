class AddMotivationToAmbassadors < ActiveRecord::Migration
  def change
    add_column :ambassadors, :motivation, :text
  end
end
