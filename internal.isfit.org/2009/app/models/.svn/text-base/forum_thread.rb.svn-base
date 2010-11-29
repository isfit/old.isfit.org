class ForumThread < ActiveRecord::Base
	has_many :forum_posts	
	
	validates_presence_of :title, :message => "A subject must contain a title."
	
	##### OBJECT METHODS ######
	def get_newest_thread
	  ForumPost.find_newest_post_for_thread(self)
	end
	
	def forum_posts
	  ForumPost.find(:all, :conditions => "forum_thread_id = #{self.id} and deleted=0")
	end
  
  def is_new(current_user)
    visits = ForumThreadVisit.find(:all, :conditions => "forum_thread_id=#{self.id} and user_id=#{current_user.id}")
	  if visits.size > 0
	    return false
	  else
	    return true
	  end
  end
  
	def get_thread_visits
	  ForumThreadVisit.find(:all, :conditions => "forum_thread_id=#{self.id}")
	end
	
	def get_last_post
	  ForumPost.find_newest_post_for_thread(self)
	end	
	
	def mark_as_new
	  # Find all thread visits to this thread
	  ForumThreadVisit.delete_all("forum_thread_id = #{self.id}")
	end
	
	##### END OBJECT METHODS ######
	
	def self.find_threads_ordered_by_latest_posts(forum_id)
	  ForumThread.find_by_sql("SELECT ft.*
    FROM forum_threads ft
    INNER JOIN forum_posts fp
    WHERE forum_id = '#{forum_id}' AND fp.created_at
    IN (

    SELECT max( created_at )
    FROM forum_posts
    WHERE forum_thread_id = ft.id AND deleted = 0
    ) GROUP BY ft.id ORDER BY fp.created_at DESC")
	end
	
	
	###### STATIC METHODS ######

  ###### END STATIC METHODS ######
	
		
end
