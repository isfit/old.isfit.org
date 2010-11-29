class PressAccreditationsController < ApplicationController
  # GET /press_accreditations
  # GET /press_accreditations.xml
  def index
    @press_accreditations = PressAccreditation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @press_accreditations }
    end
  end

  # GET /press_accreditations/1
  # GET /press_accreditations/1.xml
  def show
    @press_accreditation = PressAccreditation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @press_accreditation }
    end
  end

  # GET /press_accreditations/new
  # GET /press_accreditations/new.xml
  def new
    @press_accreditation = PressAccreditation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @press_accreditation }
    end
  end

  # GET /press_accreditations/1/edit
  def edit
    @press_accreditation = PressAccreditation.find(params[:id])
  end

  # POST /press_accreditations
  # POST /press_accreditations.xml
  def create
    @press_accreditation = PressAccreditation.new(params[:press_accreditation])

    respond_to do |format|
      if @press_accreditation.save
		Postoffice.press_acc(@press_accreditation.id).deliver
	    flash[:notice] = 'Press accreditation was successfully sent.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @press_accreditation, :status => :created, :location => @press_accreditation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @press_accreditation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /press_accreditations/1
  # PUT /press_accreditations/1.xml
  def update
    @press_accreditation = PressAccreditation.find(params[:id])

    respond_to do |format|
      if @press_accreditation.update_attributes(params[:press_accreditation])
        format.html { redirect_to(@press_accreditation, :notice => 'Press accreditation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @press_accreditation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /press_accreditations/1
  # DELETE /press_accreditations/1.xml
  def destroy
    @press_accreditation = PressAccreditation.find(params[:id])
    @press_accreditation.destroy

    respond_to do |format|
      format.html { redirect_to(press_accreditations_url) }
      format.xml  { head :ok }
    end
  end
end
