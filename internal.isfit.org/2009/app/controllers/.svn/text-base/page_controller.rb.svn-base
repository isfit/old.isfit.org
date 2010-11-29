class PageController < ApplicationController
  helper :sort
	include SortHelper
  	def list
      # sort_init 'id', :default_order => 'desc'
  	  sort_init 'tag'
  		sort_update

      @pages = Page.paginate(:page => params[:page], :conditions => "`deleted` = 0", :order => sort_clause, :per_page => 20)
      
      # @pages.each do |p|
      #   temp = p.id.split('-').[0].capitalize
      #   p.id = temp[0].capitalize
      # end
      
	  end
	    
	  def delete
      if params[:id]
        page = Page.find(params[:id])
        page.deleted = 1
        page.save
      end
      redirect_to :action => "list"
    end
    
    def create
      
      @links = SublinkController.create_linklist
      
      
      if request.post?
        if params[:id]
          @page = Page.find(params[:id])
          @page.attributes = params[:page]
          
        else
          # Fetch the posted parameters and create a new page object.
          @page = Page.new(params[:page])
        end
        
        #Kobler link og artikkel
        link = Sublink.find(@page.tag)
        link.page_id = @page.id
        link.save
          
        if @page.save
          #           unless params[:image] == ""
          #   path = "#{RAILS_ROOT}/public/images/page_images/" +
          #     "#{@page.id}.jpg"
          #   @picture = Picture.new(path, params[:image],400)
          #   @picture.save
          # end
          redirect_to :action => "list"
        else
          flash[:warnings] = @page.errors
          #Do something
        end
      else
        if params[:id]
          @page = Page.find(params[:id])
          
          # Sørger for at select boxen viser valgt link under edit
          @page.tag = Sublink.find(:first, :conditions => {:page_id => @page.id}).id
        end
      end

    end
  
  
end