class AddSubmittedByToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :submitted_by_name, :string

    add_column :ideas, :submitted_by_id, :string

  end
end
