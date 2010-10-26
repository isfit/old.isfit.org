class AddPreferencesToHost < ActiveRecord::Migration
  def self.up
    add_column :hosts, :vegetarian, :boolean
    add_column :hosts, :smoker, :boolean
    add_column :hosts, :animal, :string
    add_column :hosts, :animal_number, :integer
    add_column :hosts, :language_speak, :string
  end

  def self.down
    remove_column :hosts, :language_speak
    remove_column :hosts, :animal_number
    remove_column :hosts, :animal
    remove_column :hosts, :smoker
    remove_column :hosts, :vegetarian
  end
end
