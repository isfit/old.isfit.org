class ImfContactUnitsController < ApplicationController
  # GET /imf_contact_units
  # GET /imf_contact_units.xml
  def index
    @imf_contact_units = ImfContactUnit.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @imf_contact_units }
    end
  end

  # GET /imf_contact_units/1
  # GET /imf_contact_units/1.xml
  def show
    @imf_contact_unit = ImfContactUnit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @imf_contact_unit }
    end
  end

  # GET /imf_contact_units/new
  # GET /imf_contact_units/new.xml
  def new
    @imf_contact_unit = ImfContactUnit.new
    @units = LdapUnit.get_by_dn('ou=isfit11, ou=units, dc=isfit, dc=org').functionaries(true)
    @units_to_select = @units.collect { |x| ["#{x.lastname}, #{x.firstname}", x.id] }
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @imf_contact_unit }
    end
  end

  # GET /imf_contact_units/1/edit
  def edit
    @units = LdapUnit.get_by_dn('ou=isfit11, ou=units, dc=isfit, dc=org').functionaries(true)
    @units_to_select = @units.collect { |x| ["#{x.lastname}, #{x.firstname}", x.id] }
    @imf_contact_unit = ImfContactUnit.find(params[:id])
  end

  # POST /imf_contact_units
  # POST /imf_contact_units.xml
  def create
    @imf_contact_unit = ImfContactUnit.new(params[:imf_contact_unit])
    unless params[:file] == ""
      path = "#{RAILS_ROOT}/public/documents/imf/#{params[:file].original_filename}"
      @file = DataFile.new(path, params[:file])
      @file.save
      @imf_contact_unit.file_path = "/2011/documents/imf/#{params[:file].original_filename}"
    end 
    respond_to do |format|
      if @imf_contact_unit.save
        flash[:notice] = 'ImfContactUnit was successfully created.'
        format.html { render :action => :show, :id => @imf_contact_unit.id }
        format.xml  { render :xml => @imf_contact_unit, :status => :created, :location => @imf_contact_unit }
      else
        format.html { render :action => :index }
      end
    end
  end

  # PUT /imf_contact_units/1
  # PUT /imf_contact_units/1.xml
  def update
    @imf_contact_unit = ImfContactUnit.find(params[:id])
    unless params[:file] == ""
      path = "#{RAILS_ROOT}/public/documents/imf/#{params[:file].original_filename}"
      @file = DataFile.new(path, params[:file])
      @file.save
      @imf_contact_unit.file_path = "/2011/documents/imf/#{params[:file].original_filename}"
    end 
    respond_to do |format|
      if @imf_contact_unit.update_attributes(params[:imf_contact_unit])
        flash[:notice] = 'ImfContactUnit was successfully updated.'
        format.html { render :action => :show, :id => @imf_contact_unit.id }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @imf_contact_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /imf_contact_units/1
  # DELETE /imf_contact_units/1.xml
  def destroy
    @imf_contact_unit = ImfContactUnit.find(params[:id])
    @imf_contact_unit.destroy

    respond_to do |format|
      format.html { redirect_to(imf_contact_units_url) }
      format.xml  { head :ok }
    end
  end
end
