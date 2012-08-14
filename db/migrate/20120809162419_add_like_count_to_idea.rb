class AddLikeCountToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :like_count, :integer

  end
end
