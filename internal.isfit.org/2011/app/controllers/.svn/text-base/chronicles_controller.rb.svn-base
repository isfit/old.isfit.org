class ChroniclesController < ApplicationController
  # GET /chronicles
  # GET /chronicles.xml
  def index
    @chronicles = Chronicle.find(:all, :order => "weight DESC")
  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chronicles }
    end
  end

  # GET /chronicles/1
  # GET /chronicles/1.xml
  def show
    @chronicle = Chronicle.find(params[:id])
   
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chronicle }
    end
  end

  # GET /chronicles/new
  # GET /chronicles/new.xml
  def new
    @chronicle = Chronicle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chronicle }
    end
  end

  # GET /chronicles/1/edit
  def edit
    @chronicle = Chronicle.find(params[:id])
  end

  # POST /chronicles
  # POST /chronicles.xml
  def create
    @chronicle = Chronicle.new(params[:chronicle])
    @chronicle.weight = Chronicle.find(:first, :order => "weight DESC").weight
    @chronicle.weight += 1
    respond_to do |format|
      if @chronicle.save
        flash[:notice] = "Chronicle was saved successfully"
        format.html { render :action => "index" }
        format.xml  { render :xml => @chronicle, :status => :created, :location => @chronicle }
      else
        flash[:notice] = "Something went wrong"
        format.html { render :action => "new" }
        format.xml  { render :xml => @chronicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /chronicles/1
  # PUT /chronicles/1.xml
  def update
    @chronicle = Chronicle.find(params[:id])

    respond_to do |format|
      if @chronicle.update_attributes(params[:chronicle])
        format.html { render :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chronicle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chronicles/1
  # DELETE /chronicles/1.xml
  def destroy
    @chronicle = Chronicle.find(params[:id])
    @chronicle.destroy

    respond_to do |format|
      format.html { redirect_to(chronicles_url) }
      format.xml  { head :ok }
    end
  end

   def moveup
    current = Chronicle.find(params[:id])
    if current != Chronicle.find(:first, :order => "weight DESC")
     switch = Chronicle.find(:first, :conditions => {:weight => current.weight+1})
     switch.weight -=1
     current.weight +=1
     switch.save
     current.save
    end
    redirect_to :action => "index"
  end

  def movedown
    current = Chronicle.find(params[:id])
    if current != Chronicle.find(:last, :order => "weight DESC")
     switch = Chronicle.find(:first, :conditions => {:weight => current.weight-1 })
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

 


end
