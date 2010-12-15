class PicturesController < ApplicationController
  # GET /pictures
  # GET /pictures.xml
  def index
#    @pictures = Picture.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
  #  @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @picture }
    end
  end


  # Used to crop the image to right dimensions
  def crop
    @path = "/images/spp_article_images/" + "#{params[:article_id]}.jpg" 
  end

  def crop_page
    @path = "/images/spp_page_images/" + "#{params[:page_id]}.jpg" 
  end


  def crop_save
      path_1 = "#{RAILS_ROOT}/public/images/spp_article_images/" + "#{params[:article_id]}_1.jpg"
      path_2 = "#{RAILS_ROOT}/public/images/spp_article_images/" + "#{params[:article_id]}_2.jpg"
      path_3 = "#{RAILS_ROOT}/public/images/spp_article_images/" + "#{params[:article_id]}_3.jpg"


    orig_path = "#{RAILS_ROOT}/public/images/spp_article_images/" + "#{params[:article_id]}.jpg"

      f = Picture.new(path_1, nil,0)
      f.resize_spp(params[:x1],params[:y1],params[:x2],params[:y2],orig_path, path_1, 1)
      f.resize_spp(params[:x1_1],params[:y1_1],params[:x2_1],params[:y2_1],orig_path, path_2, 2)
      f.resize_spp(params[:x1_2],params[:y1_2],params[:x2_2],params[:y2_2],orig_path, path_3, 3)

    article = SppArticle.find(params[:article_id])
    article.image_text = params[:image_text]
    article.save
  end

  def crop_page_save
      path_1 = "#{RAILS_ROOT}/public/images/spp_page_images/" + "#{params[:page_id]}_1.jpg"
    orig_path = "#{RAILS_ROOT}/public/images/spp_page_images/" + "#{params[:page_id]}.jpg"

      f = Picture.new(path_1, nil, 0)
      f.resize_spp(params[:x1],params[:y1],params[:x2],params[:y2],orig_path, path_1, 3)


    page = SppPage.find(params[:page_id])
    page.image_text = params[:image_text]
    page.save
  end


  # GET /pictures/new
  # GET /pictures/new.xml
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @picture }
    end
  end

def new_page
    @article = Article.new

    respond_to do |format|
      format.html # new_page.html.erb
      format.xml  { render :xml => @picture }
    end
  end


  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
  end

  # POST /pictures
# POST /pictures.xml
  def create
    path = "#{RAILS_ROOT}/public/images/spp_article_images/" + "#{params[:article_id]}.jpg"
@picture = Picture.new(path, params[:image], 0)
    if  @picture.save_spp
      redirect_to(:action =>'crop', :tab=>params[:tab], :article_id => params[:article_id])
    else
      render :action => "edit"
    end
  end

  def create_page
     path = "#{RAILS_ROOT}/public/images/spp_page_images/" + "#{params[:page_id]}.jpg"
    @picture = Picture.new(path, params[:image], 0)
      if  @picture.save_spp
      redirect_to(:action =>'crop_page', :tab=>params[:tab], :page_id => params[:page_id])
      else
      render :action => "edit"
      end
    end


  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to(@picture, :notice => 'Picture was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to(pictures_url) }
      format.xml  { head :ok }
    end
  end
end
