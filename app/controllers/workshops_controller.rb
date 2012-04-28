class WorkshopsController < ApplicationController
  # GET /articles
  # GET /articles.xml
  def index
        @articles = Workshop.where(:published => true).order("number ASC")
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
      format.json { render :json => @articles }
    end
  end

  
  # GET /articles/1
  # GET /articles/1.xml
  def show
   # @article = Workshop.where(:id=>params[:id]).where("(show_article <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' OR show_article IS NULL) AND deleted='0'AND list='1'").first
   @article = Workshop.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

end
