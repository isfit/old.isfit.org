class QuizQuestion < ActiveRecord::Base
  belongs_to :quiz
  has_many :quiz_choices, :dependent=>:destroy

  def user_can_add(user_id)
    return user_can_edit(user_id)
  end

  def user_can_remove(user_id)
    return user_can_edit(user_id)
  end

  def user_can_edit(user_id)
    return quiz.user_can_edit(user_id)
  end
end
