class QuizChoice < ActiveRecord::Base
  belongs_to :quiz_question

  def user_can_add(user_id)
    return user_can_edit(user_id)
  end

  def user_can_remove(user_id)
    return user_can_edit(user_id)
  end

  def user_can_edit(user_id)
    return quiz_question.user_can_edit(user_id)
  end
end
