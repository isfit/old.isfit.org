class CreateQuizChoices < ActiveRecord::Migration
  def self.up
    create_table :quiz_choices do |t|
      t.references :quiz_question
      t.text :description
      t.integer :points

      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_choices
  end
end
