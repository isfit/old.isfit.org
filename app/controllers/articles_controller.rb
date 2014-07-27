class ArticlesController < ApplicationController
  require 'will_paginate/array'

  
  # GET /articles
  # GET /articles.xml

  def index
    #@articles = Article.where("(show_article <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' OR show_article IS NULL)").where(deleted: 0).where(list: 1).order("weight DESC").limit(5)
    #if Language.to_s =="en"
    #  @articles.reject!{|x| x.title_en == "" }
    #else
    #  @articles.reject!{|x| x.title_no == "" }
    #end
    #@latest = @articles

    #render layout: "application_no_boxes"
    redirect_to root_path
  end

  def archive
    @articles.all
  end

  # GET /articles/all
  # GET /articles/all.xml
  def all
    @articles = Article.find(:all, :conditions=>"(show_article <='"+Time.now.strftime("%Y-%m-%d %H:%M:%S")+"' OR show_article IS NULL) AND deleted='0'AND list='1'", :order => "weight DESC")
    if Language.to_s =="en"
      @articles.reject!{|x| x.title_en == "" }
    else
      @articles.reject!{|x| x.title_no == "" }
    end
    
    @articles = @articles.paginate(:page => params[:page], per_page: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  def latest_blogpost
    @article = Article.where(blog: 1).order("weight").last

    redirect_to @article
  end 

  def blog
    @blog_posts = Article.blog_articles(Language.to_s)

    render layout: "application_no_boxes"
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
