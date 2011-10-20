class ProjectSupportsController < ApplicationController
  # GET /project_supports
  # GET /project_supports.xml
#  def index
#    @project_supports = ProjectSupport.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @project_supports }
#    end
#  end

  # GET /project_supports/1
  # GET /project_supports/1.xml
#  def show
#    @project_support = ProjectSupport.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @project_support }
#    end
#  end

  # GET /project_supports/new
  # GET /project_supports/new.xml
  def new
    @countries = Country.all
    @age = 0..100
    dummy_workshop = Workshop.new
    dummy_workshop.id = -1
    dummy_workshop.name = "None"
    @workshops = Workshop.all
    @workshops.insert(0, dummy_workshop)
    @associations = ["Functionary", "Participant -> Dialogue groups", "Participant -> Workshop"]
    @project_support = ProjectSupport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project_support }
    end
  end

  # GET /project_supports/1/edit
#  def edit
#    @project_support = ProjectSupport.find(params[:id])
#  end

  # POST /project_supports
  # POST /project_supports.xml
  def create
    @countries = Country.all
    @age = 0..100
    dummy_workshop = Workshop.new
    dummy_workshop.id = -1
    dummy_workshop.name = "None"
    @workshops = Workshop.all
    @workshops.insert(0, dummy_workshop)
    @associations = ["Functionary", "Participant -> Dialogue groups", "Participant -> Workshop"]

    @project_support = ProjectSupport.new(params[:project_support])
    if @project_support.workshop_id == -1
      @project_support.workshop = nil
    end

    if @project_support.country_id == -1
      @project_support.country = nil
    end

    respond_to do |format|
      if @project_support.save and ProjectSupportMailer.application_mail(@project_support).deliver and ProjectSupportMailer.verification_mail(@project_support.person_mail).deliver
        #format.html { redirect_to (:action=>"success", :tab=>params[:tab], :notice => 'Project support was successfully created.') }
      else
        #format.html { render :action => "new", :tab=>params[:tab] }
      end
    end
  end

  def success
  end

  # PUT /project_supports/1
  # PUT /project_supports/1.xml
#  def update
#    @project_support = ProjectSupport.find(params[:id])
#
#    respond_to do |format|
#      if @project_support.update_attributes(params[:project_support])
#        format.html { redirect_to(@project_support, :notice => 'Project support was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @project_support.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /project_supports/1
  # DELETE /project_supports/1.xml
#  def destroy
#    @project_support = ProjectSupport.find(params[:id])
#    @project_support.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(project_supports_url) }
#      format.xml  { head :ok }
#    end
#  end
end
