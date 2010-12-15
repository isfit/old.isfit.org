class SppPageController < ApplicationController

  helper :sort
	include SortHelper
    
  def index
    sort_init 'title'
		sort_update
    
    @pages = SppPage.find(:all, :order => sort_clause) 
  
  end
  
  def new
  
    if params[:spp_page]
      
      if params[:id]   
        @spp = SppPage.find(params[:id])
        @spp.attributes = params[:spp_page]
       
      else
        @spp = SppPage.new(params[:spp_page])
      end
      
      if @spp.save
        flash[:notice] = 'Page created'
        redirect_to :action => 'index'
      else
        flash[:warnings]  = @spp.errors
      end 
    elsif params[:id]
      @spp = SppPage.find(params[:id])
    end      
  end
  
end
  