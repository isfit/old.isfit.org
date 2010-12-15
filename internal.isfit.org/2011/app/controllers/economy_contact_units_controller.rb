class EconomyContactUnitsController < ApplicationController
  helper :sort
  include SortHelper
  # GET /economy_contact_units
  # GET /economy_contact_units.xml
  def index
    sort_init 'id'
    sort_update

    @economy_contact_units = EconomyContactUnit.find(:all, :order => sort_clause)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @economy_contact_units }
    end
  end

  # GET /economy_contact_units/1
  # GET /economy_contact_units/1.xml
  def show
    if can_access?('economy_contact_units', 'can_show')
      @economy_contact_unit = EconomyContactUnit.find(params[:id])
    end
    @edit_all = can_access?('economy_contact_logs', 'edit_all')
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @economy_contact_unit }
    end
  end

  # GET /economy_contact_units/new
  # GET /economy_contact_units/new.xml
  def new
    @economy_contact_unit = EconomyContactUnit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @economy_contact_unit }
    end
  end

  # GET /economy_contact_units/1/edit
  def edit
    @economy_contact_unit = EconomyContactUnit.find(params[:id])
  end

  # POST /economy_contact_units
  # POST /economy_contact_units.xml
  def create
    @economy_contact_unit = EconomyContactUnit.new(params[:economy_contact_unit])

    respond_to do |format|
      if @economy_contact_unit.save
        flash[:notice] = 'EconomyContactUnit was successfully created.'
        format.html { render :action => "show", :id => @economy_contact_unit.id }
        format.xml  { render :xml => @economy_contact_unit, :status => :created, :location => @economy_contact_unit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @economy_contact_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /economy_contact_units/1
  # PUT /economy_contact_units/1.xml
  def update
    @economy_contact_unit = EconomyContactUnit.find(params[:id])

    respond_to do |format|
      if @economy_contact_unit.update_attributes(params[:economy_contact_unit])
        flash[:notice] = 'EconomyContactUnit was successfully updated.'
        format.html { render :action => "show", :id => @economy_contact_unit.id }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @economy_contact_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /economy_contact_units/1
  # DELETE /economy_contact_units/1.xml
  def destroy
    @economy_contact_unit = EconomyContactUnit.find(params[:id])
    @economy_contact_unit.destroy

    respond_to do |format|
      format.html { redirect_to(economy_contact_units_url) }
      format.xml  { head :ok }
    end
  end
end
