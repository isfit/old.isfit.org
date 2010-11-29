class EconomyContactUnitTypesController < ApplicationController
  # GET /economy_contact_unit_types
  # GET /economy_contact_unit_types.xml
  def index
    @economy_contact_unit_types = EconomyContactUnitType.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @economy_contact_unit_types }
    end
  end

  # GET /economy_contact_unit_types/1
  # GET /economy_contact_unit_types/1.xml
  def show
    @economy_contact_unit_type = EconomyContactUnitType.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @economy_contact_unit_type }
    end
  end

  # GET /economy_contact_unit_types/new
  # GET /economy_contact_unit_types/new.xml
  def new
    @economy_contact_unit_type = EconomyContactUnitType.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @economy_contact_unit_type }
    end
  end

  # GET /economy_contact_unit_types/1/edit
  def edit
    @economy_contact_unit_type = EconomyContactUnitType.find(params[:id])
  end

  # POST /economy_contact_unit_types
  # POST /economy_contact_unit_types.xml
  def create
    @economy_contact_unit_type = EconomyContactUnitType.new(params[:economy_contact_unit_type])

    respond_to do |format|
      if @economy_contact_unit_type.save
        flash[:notice] = 'EconomyContactUnitType was successfully created.'
        format.html { redirect_to(economy_contact_unit_) }
        format.xml  { render :xml => @economy_contact_unit_type, :status => :created, :location => @economy_contact_unit_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @economy_contact_unit_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /economy_contact_unit_types/1
  # PUT /economy_contact_unit_types/1.xml
  def update
    @economy_contact_unit_type = EconomyContactUnitType.find(params[:id])

    respond_to do |format|
      if @economy_contact_unit_type.update_attributes(params[:economy_contact_unit_type])
        flash[:notice] = 'EconomyContactUnitType was successfully updated.'
        format.html { redirect_to(@economy_contact_unit_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @economy_contact_unit_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /economy_contact_unit_types/1
  # DELETE /economy_contact_unit_types/1.xml
  def destroy
    @economy_contact_unit_type = EconomyContactUnitType.find(params[:id])
    @economy_contact_unit_type.destroy

    respond_to do |format|
      format.html { redirect_to(economy_contact_unit_types_url) }
      format.xml  { head :ok }
    end
  end
end
