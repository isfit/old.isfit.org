class Quiz < ActiveRecord::Base
  has_many :quiz_questions, :dependent=>:destroy
  has_many :quiz_users, :dependent=>:destroy

  def Quiz.user_can_add(user_id)
    return true
  end

  def user_can_remove(user_id)
    return user_can_edit(user_id)
  end

  def user_can_edit(user_id)
    # 519 : Sindre Hansen
    if (user_id == 519 or user_id == self.owner_id) then
	return true
    end
      return false
  end

end

