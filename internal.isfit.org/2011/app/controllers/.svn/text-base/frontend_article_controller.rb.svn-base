class FrontendArticleController < ApplicationController
  # GET /articles
  # GET /articles.xml

  helper :sort
  include SortHelper
  
  def index
    @articles = FrontendArticle.find(:all, :order => "weight DESC", :conditions=> {:deleted => "0"})
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = FrontendArticle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  def new_pic
    @photo = Photo.new
    @pictures = Photo.find(:all)
  end

  def crop_main
    if params[:photo][:orignal_picture]!= nil
      @picture = Photo.new(params[:photo])
      if !@picture.save
        render :action =>"new_pic"
      end
    elsif params[:stuff]["item_id"] != nil
      @picture =Photo.find(params[:stuff]["item_id"])
    end
  end

  def crop_create
    if params[:id]
      @article = FrontendArticle.find(params[:id])
    else
      @article = FrontendArticle.new
      @article.list = 0
      @article.deleted = 0
      @article.weight = FrontendArticle.find(:first, :order => "weight DESC").weight+1

    end
      @picture = Photo.find(params[:picture])
      @article.image_text_no = @picture.image_text_no
      @article.image_text_en = @picture.image_text_en
      @article.image_credits = @picture.credits

    if @article.save
      url = (Rails.root + "/public/images/"+ @picture.original_picture.url)
      url = url.to_s.gsub!(/\?[1234567890]+/, "")
      url_pic = Rails.root + "/public/images/frontend_article_images/#{@article.id}_1.jpg"
      @main = resize(params[:x1],params[:y1],params[:x2],params[:y2],url, 1, url_pic)
       url_pic = Rails.root + "/public/images/frontend_article_images/#{@article.id}_2.jpg"
      @half = resize(params[:x1_1],params[:y1_1],params[:x2_1],params[:y2_1],url, 2, url_pic)
      url_pic = Rails.root + "/public/images/frontend_article_images/#{@article.id}_3.jpg"
      @article_pic = resize(params[:x1_2],params[:y1_2],params[:x2_2],params[:y2_2],url, 3, url_pic)
      redirect_to edit_frontend_article_path(params[:tab], @article)
    end


  end

  def new_pic_save

    @article = FrontendArticle.new
    @article.deleted = 1
    @article.save
     respond_to do |format|
      if @article.save
        format.html { redirect_to(edit_article_path(@article), :notice => "Photo successfully added") }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end

  end


  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = FrontendArticle.new
    @pictures = Photo.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
    

  end

  # GET /articles/1/edit
  def edit
    @article = FrontendArticle.find(params[:id])
    @functionaries = 
			LdapUnit.get_by_dn("ou=isfit11,ou=units,dc=isfit,dc=org").functionaries(true)
    @current_byline = LdapUser.get_by_id(@article.byline_func_id)

  end

  def update_picture
    respond_to do |format|
      format.html
      format.js
    end
  end

# POST /articles
# POST /articles.xml
  def create
    func = LdapUser.get_by_id(params[:byline_func][:func].to_i)
    byline = "<a href=\"mailto:#{func.username}@isfit.org\">#{func.firstname} #{func.lastname}</a>"
    saved = false
    if (@article = FrontendArticle.find(params[:id])) != nil
      @article.byline = byline
      @article.byline_func_id = params[:byline_func][:func].to_i
      if FrontendArticle.all.count == 1
        #@article.weight = 1
      else
        #@article.weight = FrontendArticle.find(:first, :order => "weight DESC").weight+1
      end
      if @article.update_attributes(params[:article])
        saved = true
      end
    else
      @article = FrontendArticle.new(params[:article])
      @article.byline = byline
      @article.byline_func_id = params[:byline_func][:func].to_i
      if FrontendArticle.all.count == 1
        #@article.weight = 1
      else
        #@article.weight = FrontendArticle.find(:first, :order => "weight DESC").weight
      end      
      if @article.save
        saved = true
      end
    end
    respond_to do |format|
      if saved
        format.html { redirect_to(:action=>"index", :notice => 'Article was successfully created.') }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  def article_image(picture_id, type)
    picture = Photo.find_by_id(picture_id)
    url = "<div><img src =/images/#{picture.full_article_picture.url} /></div>"
  end


  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = FrontendArticle.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to(@article, :notice => 'Article was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def delete
    @article = FrontendArticle.find(params[:id])
    @article.deleted = 1
    @article.save

    respond_to do |format|
      format.html { redirect_to(:action=>"index") }
      format.xml  { head :ok }
    end
  end

  def moveup
    current = FrontendArticle.find(params[:id])
    if current != FrontendArticle.find(:first, :order => "weight DESC") && FrontendArticle.get_all_not_deleted.count > 1
     switch = FrontendArticle.find(:first, :conditions => ["weight > #{current.weight} AND deleted = 0" ,{ :deleted=>"0"}], :order =>"weight ASC")
     switch.weight -=1
     current.weight +=1
     switch.save
     current.save
    end
    redirect_to :action => "index"
  end

  def movedown
    current = FrontendArticle.find(params[:id])
    if current != FrontendArticle.find(:last, :order => "weight DESC") && FrontendArticle.get_all_not_deleted.count > 1
     switch = FrontendArticle.find(:first, :conditions => ["weight < #{current.weight} AND deleted = 0" ,{ :deleted=>"0"}], :order =>"weight DESC")
     switch.weight +=1
     current.weight -=1
     switch.save
     current.save
    end



    redirect_to :action => "index"
  end
  private

  def set_article_weight(article)
    if FrontendArticle.all.count == 1
      article.weight = 1
    else
      article.weight = FrontendArticle.find(:first, :order => "weight DESC").weight
    end
  end

  def resize(x1,y1,x2, y2, path, type, out)
    img_orig = Magick::Image.read(path).first
    img_orig.crop!(x1.to_i,y1.to_i,(x2.to_i-x1.to_i),(y2.to_i-y1.to_i))
    if type == 1
      img_orig.resize_to_fit!(531,196)
    elsif type == 2
      img_orig.resize_to_fit!(253,136)
    else
      img_orig.resize_to_fit!(531,250)
    end
    img_orig.write(out)
    img_orig.to_blob
  end

end
