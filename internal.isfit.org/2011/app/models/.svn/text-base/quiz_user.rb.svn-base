class QuizUser < ActiveRecord::Base
  belongs_to :quiz

  def QuizUser.get_best_users(quiz_id)
    self.find_by_sql("SELECT *, points/guesses AS rating FROM `quiz_users` WHERE quiz_id=" + (quiz_id).to_s + " ORDER BY rating DESC, points DESC LIMIT 10")
  end
end
