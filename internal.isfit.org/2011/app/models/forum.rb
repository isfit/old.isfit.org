class Forum < ActiveRecord::Base
	
	
	def self.find_for_user(user)
	  forums = self.find(:all)
	  
	  return_forums = []
	  for forum in forums
	    if user.is_in_group?(forum.group_dn)
	      return_forums.push(forum)
	    end
	  end
	  return return_forums
	end
	
	def get_number_of_threads
    ForumThread.find_all_by_forum_id(self.id).size
  end
  
  def get_number_of_posts
    threads = ForumThread.find_all_by_forum_id(self.id)
    
    nof_posts = 0
    for t in threads
      nof_posts += ForumPost.get_posts_by_thread(t).size
    end
    return nof_posts
  end
  
  def get_last_forum_post 
      threads = ForumThread.find_all_by_forum_id(self.id)
      return_post = nil
    	for thread in threads
    	  if return_post == nil
    	    return_post = thread.get_newest_thread
    	  else
    	    newest_thread = thread.get_newest_thread
    	    if newest_thread != nil and newest_thread.created_at > return_post.created_at
    	      return_post = thread.get_newest_thread
    	    end
    	  end
    	end
    	return return_post
  end
  
end