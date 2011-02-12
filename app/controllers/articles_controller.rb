class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.xml
  def index
    #@articles = Article.find(:all, :conditions=>"show_article <="+Time.now.to_s+" OR show_article IS NULL", :order => "weight DESC",:conditions=> {:deleted=>"0", :list=>"1"})
    @articles = Article.find(:all, :conditions=>"(show_article <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' OR show_article IS NULL) AND deleted='0'AND list='1'", :order => "weight DESC")
    if Language.to_s =="en"
      @articles.reject!{|x| x.title_en == "" }
    else
      @articles.reject!{|x| x.title_no == "" }
    end
    @articles = @articles[0..12]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
      format.json { render :json => @articles }
    end
  end

  def all
    @articles = Article.find(:all, :conditions=>"(show_article <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' OR show_article IS NULL) AND deleted='0'AND list='1'", :order => "weight DESC")
    if Language.to_s =="en"
      @articles.reject!{|x| x.title_en == "" }
    else
      @articles.reject!{|x| x.title_no == "" }
    end
    @articles = @articles[13..-1]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.where(:id=>params[:id]).where("(show_article <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' OR show_article IS NULL) AND deleted='0'AND list='1'").first

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

end
