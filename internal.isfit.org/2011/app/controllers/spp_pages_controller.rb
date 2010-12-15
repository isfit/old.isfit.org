class SppPagesController < ApplicationController
  helper :sort
  include SortHelper
  #GET /pages
  # GET /pages.xml
  def index
    sort_init 'id'
    sort_update  

    @pages = SppPage.find(:all, :order => sort_clause)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = SppPage.find(params[:id])
    @picture_path ="#{RAILS_ROOT}/public/images/spp_page_images/" + "#{@page.id}.jpg"
    @picture = false
      if File.exists?(@picture_path)
        @picture_path = "/images/spp_page_images/" + "#{@page.id}_1.jpg"
        @picture = true
      end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = SppPage.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = SppPage.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    
    @page = SppPage.new(params[:spp_page])
    respond_to do |format|
      if @page.save
        format.html { redirect_to(:controller=>'pictures', :action=>'new_page', :tab=>params[:tab], :page_id=>@page.id) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = SppPage.find(params[:id])
    respond_to do |format|
      if @page.update_attributes(params[:spp_page])
        format.html { redirect_to(spp_pages_path, :notice => 'Page was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = SppPage.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(pages_url) }
      format.xml  { head :ok }
    end
  end
end
