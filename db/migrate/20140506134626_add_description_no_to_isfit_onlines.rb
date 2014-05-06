class AddDescriptionNoToIsfitOnlines < ActiveRecord::Migration
  def change
    add_column :isfit_onlines, :description_no, :text
  end
end
