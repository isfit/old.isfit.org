class BlogController < ApplicationController

  def index
    @blogs = Blog.find(:all)
  end
  
  def show
    @blog = Blog.find(params[:id])
    @comment = Comment.new( :blog => @blog )
  end
  
  def edit
    @blog = Blog.find(params[:id])
    if @blog and request.post?
      if @blog and @blog.update_attributes(params[:blog])
        flash[:notice] = 'Blog post updated'
      else
        flash[:error] = 'Unable to update blog post'
      end
	  else
	  flash[:warnings]
	  end
  end
  
  def create
    if params[:blog]
      @blog = Blog.new(params[:blog])
      if @blog.save
        flash[:notice] = 'Blog post created'
        redirect_to :action => 'list'
      else
        render :action => 'new'
      end
    else
      flash[:warnings]
    end
  end
  
  def comment
    @blogs = Blog.find(:all)
  end

end