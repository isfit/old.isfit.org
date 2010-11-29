class SppArticlesController < ApplicationController
  helper :sort
  include SortHelper
  # GET /articles
  # GET /articles.xml
  def index
    @grid4_counter = 0
    sort_init 'id'
    sort_update  
    @articles = SppArticle.find(:all, :conditions => "deleted = 0", :order => sort_clause)

    #@articles = @articles.sort_by { |x| x.main_article? ? 0 : 1 }

    #@articles.each do |a|
    #if a.ingress_en.size > 380
    # a.ingress_en = a.ingress_en[0...373]
    # a.ingress_en << '...' 
    # end
    #end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = SppArticle.find(params[:id])
    @picture_path ="#{RAILS_ROOT}/public/images/spp_article_images/" + "#{@article.id}.jpg"
    @picture = false
    if File.exists?(@picture_path)
      @picture_path = "/images/spp_article_images/" + "#{@article.id}_3.jpg"
      @picture = true
    end
    @length = @article.ingress_en.size+@article.body_en.size
    @for_each = (@length-500)/3
    @first =[]
    @second = []
    @third = []
    @body_length = @for_each - @article.ingress_en.size
    @stop = 0
    for i in (@body_length+500)...@article.body_en.size
      if @article.body_en[i].chr == '.'
        @first = @article.body_en[0...i+1]
        @stop = i+1
        break
      end
    end
    for i in @stop+@for_each...@article.body_en.size
       if @article.body_en[i].chr == '.'
        @second = @article.body_en[@stop...i+1]
        @stop = i+1
        break
      end
    end
    @third = @article.body_en[@stop...@article.body_en.size]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  def new
    @article = SppArticle.new
    if SppArticle.find(:last) != nil
      @last = SppArticle.find(:last).id +=1
    else
      @last = 1
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
    
  end

  def create
    @article = SppArticle.new(params[:spp_article])
    @article.deleted = 0
    save_article
  end

  def edit
    @article = SppArticle.find(params[:id])
  end

  def update
    @article = SppArticle.find(params[:id])
    @article.attributes = params[:spp_article]
    edit_article
  end

  def delete
    @article = SppArticle.find(params[:id])
    @article.deleted = 1
    edit_article
  end

  private

  def save_article
    if @article.save
      redirect_to(:controller=> 'pictures', :action=>'new', :tab=>'editorial', :article_id =>@article.id)
      #redirect_to(spp_articles_path)
    else
      render(:action => 'new')
    end
  end

  def edit_article
    if @article.save
     # redirect_to(:controller=> 'pictures', :action=>'new', :tab=>'editorial', :article_id =>@article.id)
      redirect_to(spp_articles_path)
    else
      render(:action => 'new')
    end
  end

end
