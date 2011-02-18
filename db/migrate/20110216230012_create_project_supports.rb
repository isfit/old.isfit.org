class CreateProjectSupports < ActiveRecord::Migration
  def self.up
    create_table :project_supports do |t|
      t.string :person_name
      t.integer :person_age
      t.integer :country_id
      t.string :person_mail
      t.string :person_association
      t.integer :workshop_id
      t.text :group_description
      t.text :project_description
      t.text :funds_description

      t.timestamps
    end
  end

  def self.down
    drop_table :project_supports
  end
end
