class FrontendArticleController < ApplicationController
  
  helper :sort
	include SortHelper
	$weights = {'Highest' => 0, 'Even higher' => 1, 'Higher' => 2, 'High' => 3, 'Medium' => 4, 'Low' => 5}
	$weights_text = ['Highest', 'Even higher', 'Higher', 'High', 'Medium', 'Low']
  def index
    sort_init 'created_at', :default_order => 'desc'
		sort_update
    
    @articles = FrontendArticle.paginate(:page => params[:page], :order => sort_clause, :conditions => "`deleted` = 0", :per_page => 20)
  end

  def create
    if request.post?
      if params[:id]
        @article = FrontendArticle.find(params[:id])
        @article.attributes = params[:article]
      else
        # Fetch the posted parameters and create a new article object.
        @article = FrontendArticle.new(params[:article])
      end      
      if @article.save
        unless params[:image] == ""
  				path = "#{RAILS_ROOT}/public/images/frontend_article_images/" +
  					"#{@article.id}.jpg"
  				@picture = Picture.new(path, params[:image],400)
  				@picture.save
  			end
        redirect_to :action => "index"
      else
        flash[:warnings] = @article.errors
        #Do something
      end
    else
      if params[:id]
        @article = FrontendArticle.find(params[:id])
      end
    end
    
  end
  
  def delete
    if params[:id]
      article = FrontendArticle.find(params[:id])
      article.deleted = 1
      article.save
    end
    redirect_to :action => "index"
  end
  
end
