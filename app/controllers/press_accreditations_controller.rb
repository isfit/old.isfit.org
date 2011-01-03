class PressAccreditationsController < ApplicationController

  # GET /press_accreditations/new
  # GET /press_accreditations/new.xml
  def new
    @press_accreditation = PressAccreditation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @press_accreditation }
    end
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
end
