class CreateQuizQuestions < ActiveRecord::Migration
  def self.up
    create_table :quiz_questions do |t|
      t.references :quiz
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :quiz_questions
  end
end
