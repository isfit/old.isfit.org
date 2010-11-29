class PersonalContactsController < ApplicationController

	helper :sort
	include SortHelper
  # GET /personal_contacts
  # GET /personal_contacts.xml
  def index
    @regions = Region.find(:all)
    @personal_contacts = PersonalContact.find(:all)
  end

  def list
		sort_init 'id'
		sort_update
    if params[:cid]
      @personal_contacts = PersonalContact.find_all_by_country_id(params[:cid], :order => sort_clause)
    elsif params[:rid]
      @personal_contacts= PersonalContact.find_all_by_region_id(params[:rid], :order => sort_clause)
    else
      @personal_contacts = PersonalContact.find(:all, :order=>sort_clause)
    end
    @personal_contacts
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @personal_contacts }
    end
  end
  def show_countries
    @rid = params[:rid]
    render :partial => "country_count", :locals =>{ :rid => @rid }
  end

  # GET /personal_contacts/1
  # GET /personal_contacts/1.xml
  def show
    @personal_contact = PersonalContact.find(params[:id])

#    respond_to do |format|
 #     format.html # show.html.erb
  #    format.xml  { render :xml => @personal_contact }
   # end
  end

  # GET /personal_contacts/new
  # GET /personal_contacts/new.xml
  def new
    @personal_contact = PersonalContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @personal_contact }
    end
  end

  # GET /personal_contacts/1/edit
  def edit
    @personal_contact = PersonalContact.find(params[:id])
  end

  # POST /personal_contacts
  # POST /personal_contacts.xml
  def create
    @personal_contact = PersonalContact.new(params[:personal_contact])

    respond_to do |format|
      if @personal_contact.save
        flash[:notice] = 'PersonalContact was successfully created.'
        format.html { redirect_to(@personal_contact) }
        format.xml  { render :xml => @personal_contact, :status => :created, :location => @personal_contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @personal_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /personal_contacts/1
  # PUT /personal_contacts/1.xml
  def update
    @personal_contact = PersonalContact.find(params[:id])

    respond_to do |format|
      if @personal_contact.update_attributes(params[:personal_contact])
        flash[:notice] = 'PersonalContact was successfully updated.'
        format.html { redirect_to(@personal_contact) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @personal_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_contacts/1
  # DELETE /personal_contacts/1.xml
  def destroy
    @personal_contact = PersonalContact.find(params[:id])
    @personal_contact.destroy

    respond_to do |format|
      format.html { redirect_to(personal_contacts_url) }
      format.xml  { head :ok }
    end
  end
end
