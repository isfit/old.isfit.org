class ForumPost < ActiveRecord::Base
	belongs_to :forum_thread
	validates_presence_of :body, :message => "Your message can't be left blank!"
	
	##### OBJECT METHODS ######
	
	def is_newer_than(post)
	  
	end
	##### END OBJECT METHODS ######
	
	
	###### STATIC METHODS ######
	
	def self.get_posts_by_thread(thread)
	  self.find(:all, :conditions => "forum_thread_id=#{thread.id} and deleted=0")
	end
	
	def self.find_newest_post_for_thread(thread)
	  post = self.find(:first, :conditions => "forum_thread_id=#{thread.id} and deleted=0", :order => 'created_at desc')
	end
	###### END STATIC METHODS ######
	
	
end