class AddStudentToHost < ActiveRecord::Migration
  def change
    add_column :hosts, :student, :boolean

  end
end
