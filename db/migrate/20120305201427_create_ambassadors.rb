class CreateAmbassadors < ActiveRecord::Migration
  def change
    create_table :ambassadors do |t|
      t.string :name
      t.string :address
      t.string :zip_code
      t.string :email
      t.string :city
      t.references :country
      t.integer :infopackage_contact_type_id

      t.timestamps
    end
    add_index :ambassadors, :country_id
  end
end
