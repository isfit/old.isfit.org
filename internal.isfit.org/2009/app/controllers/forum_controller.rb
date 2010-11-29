class ForumController < ApplicationController
  
  def index
      redirect_to :action => "list_forums"
  end
  def list_forums
    forums = Forum.find_for_user(current_user)
		@forums = forums.paginate(:page => params[:page], :per_page => 120)
  end
  
  def show_forum
    # Get threads in this forum (params[:id] = forum, i.e. group_dn)
    @forum = Forum.find_by_id(params[:id])
    if current_user.is_in_group?(@forum.group_dn)
      @threads = ForumThread.find_threads_ordered_by_latest_posts(@forum.id)
    else
      redirect_to :action => "list_forums"
    end
  end
  
  def show_thread
    # Get all posts in this thread. Display them as a "paginate" page
    @thread = ForumThread.find(params[:id])
    @posts = @thread.forum_posts.paginate(:page => params[:page], :per_page => 8)
    ftvs = ForumThreadVisit.find(:first, :conditions => "user_id=#{current_user.id} and forum_thread_id = #{@thread.id}")
    unless ftvs != nil
      ftv = ForumThreadVisit.new(:user_id => current_user.id, :forum_thread_id => @thread.id)
      ftv.save
    end
    if params[:iframe]
      render :action => "show_thread", :layout => 'content_only'
    end
  end
  
  def edit_post
    if request.post?
      @forum_post = ForumPost.find(params[:forum_post][:id])
      @forum_post.attributes = params[:forum_post]
      @forum_thread = ForumThread.find(@forum_post.forum_thread_id)
      if @forum_post.user_id != current_user.id
        redirect_to :action => "list_forums"
      end
      if @forum_post.save
        redirect_to :action => "show_thread", :id => @forum_thread.id
      else
        flash[:warnings] = @forum_post.errors
      end        
      
    else
      @forum_thread = ForumThread.find(params[:forum_thread_id])
      @forum_post = ForumPost.find(params[:forum_post_id])
      if @forum_post.user_id != current_user.id
        redirect_to :action => "list_forums"
      end
    end
  end
  
  def create_post
    
    @thread = ForumThread.find(params[:id])
    forum = Forum.find_by_id(@thread.forum_id)
    
    if current_user.is_in_group?(forum.group_dn)
      
    else
      redirect_to :action => "list_forums"
    end

    if request.post?

      # Fetch the posted parameters and create a new ForumPost object.
      @forum_post = ForumPost.new(params[:forum_post])
      
      @forum_post.forum_thread_id = @thread.id
      @forum_post.user_id = current_user.id
      if @forum_post.save
        
        # Mark thread as new for all users
        @thread.mark_as_new #move down to after save..
        
        redirect_to :action => "show_thread", :id => @thread.id
      else
        flash[:warnings] = @forum_post.errors
      end
    end
  end
  
  def create_thread
     forum = Forum.find_by_id(params[:id])
      if !current_user.is_in_group?(forum.group_dn)
        redirect_to :action => "list_forums"
      end
    
    if request.post?
      @thread = ForumThread.new(params[:forum_thread])
      @thread.forum_id = params[:id]
      
      if @thread.save
        @forum_post = ForumPost.new(params[:forum_post])
        @forum_post.forum_thread_id = @thread.id
        @forum_post.user_id = current_user.id
        if @forum_post.save
        
          # Mark thread as new for all users
          @thread.mark_as_new #move down to after save..
        
          redirect_to :action => "show_thread", :id => @thread.id
        else
          flash[:warnings] = @forum_post.errors
        end
      else
        flash[:warnings] = @thread.errors
      end
    end
  end
  
  def delete_post
    forum_post = ForumPost.find(params[:id])
    if forum_post != nil and forum_post.user_id == current_user.id
      forum_post.deleted = 1
      forum_post.save
    end
    redirect_to :action => "show_thread", :id => params[:thread_id]
  end
end