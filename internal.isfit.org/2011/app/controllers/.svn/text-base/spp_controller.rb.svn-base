class SppController < ApplicationController
  
  helper :sort
	include SortHelper
    
  def index
    sort_init 'created_at', :default_order => 'desc'
		sort_update
    
    @articles = SppArticle.find(:all, :order => sort_clause, :conditions => "`deleted` = 0") 
    
  end
  
  def new
    if params[:spp_article]
    
      if params[:id]
        
        @spp = SppArticle.find(params[:id])
        @spp.attributes = params[:spp_article]
       
      else
        @spp = SppArticle.new(params[:spp_article])
        @spp.deleted = 0
      end
      if @spp.save
        unless params[:image] == ""
    		  path = "#{RAILS_ROOT}/public/images/spp_article_images/" + "#{@spp.id}.jpg"
    		  @picture = Picture.new(path, params[:image],400)
    			@picture.save
    		end
        flash[:notice] = 'Article created'
        redirect_to :action => 'index'
      else
        flash[:warnings]  = @spp.errors
      end 
    elsif params[:id]
      @spp = SppArticle.find(params[:id])
    end      
  end
  
  def delete
    if params[:id]
      article = SppArticle.find(params[:id])
      article.deleted = 1
      article.save
    end
    redirect_to :action => "index"
  end
  
  

end
