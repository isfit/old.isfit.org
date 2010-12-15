class EconomyContactLogsController < ApplicationController
  def show
    @economy_contact_log = EconomyContactLog.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @economy_contact_log }
    end
  end

  # GET /economy_contact_logs/new
  # GET /economy_contact_logs/new.xml
  def new
    if can_access?('economy_contact_logs', 'add_new')
      @economy_contact_log = EconomyContactLog.new
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @economy_contact_log }
    end
  end

  # GET /economy_contact_logs/1/edit
  def edit 
    if can_access?('economy_contact_logs', 'edit_all') || EconomyContactLog.find_by_functionary_id(current_user.id)
      @economy_contact_log = EconomyContactLog.find(params[:id])
    end
  end

  # POST /economy_contact_logs
  # POST /economy_contact_logs.xml
  def create
    @economy_contact_log = EconomyContactLog.new(params[:economy_contact_log])

    respond_to do |format|
      if @economy_contact_log.save
        flash[:notice] = 'EconomyContactLog was successfully created.'
        format.html { render :action => 'show', :id => @economy_contact_log.id }
        format.xml  { render :xml => @economy_contact_log, :status => :created, :location => @economy_contact_log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @economy_contact_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /economy_contact_logs/1
  # PUT /economy_contact_logs/1.xml
  def update
    @economy_contact_log = EconomyContactLog.find(params[:id])

    respond_to do |format|
      if @economy_contact_log.update_attributes(params[:economy_contact_log])
        flash[:notice] = 'EconomyContactLog was successfully updated.'
        format.html { render :controller => "economy_contact_units", :action => "show", :id => @economy_contact_log.economy_contact_unit_id }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @economy_contact_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /economy_contact_logs/1
  # DELETE /economy_contact_logs/1.xml
  def destroy
    @economy_contact_log = EconomyContactLog.find(params[:id])
    if can_access?('economy_contact_logs', 'destroy_all') || current_user.id == @economy_contact_log.functionary_id
      flash[:notice] = 'This log was deleted.'
      @economy_contact_log.deleted = 1
      @economy_contact_log.save
    end

    respond_to do |format|
      format.html { render :controller => "economy_contact_units", :action => "show", :id => @economy_contact_log.economy_contact_unit_id }
      format.xml  { head :ok }
    end
  end
end
