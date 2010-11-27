class PagesController < ApplicationController
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])
    if @page.id == 28
      render :layout => 'application_no_boxes'
      return
    elsif @page.id == 10
      render :layout => :false
      return
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

end
