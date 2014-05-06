class AddColumnsToIsFiTOnline < ActiveRecord::Migration
  def change
    add_column :isfit_onlines, :start_date, :datetime
    add_column :isfit_onlines, :end_date, :datetime
    add_column :isfit_onlines, :description, :text
  end
end
