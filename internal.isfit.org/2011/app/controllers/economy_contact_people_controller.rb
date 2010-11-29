class EconomyContactPeopleController < ApplicationController
  # GET /economy_contact_people
  # GET /economy_contact_people.xml
  def index
    @economy_contact_people = EconomyContactPerson.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @economy_contact_people }
    end
  end

  # GET /economy_contact_people/1
  # GET /economy_contact_people/1.xml
  def show
    @economy_contact_person = EconomyContactPerson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @economy_contact_person }
    end
  end

  # GET /economy_contact_people/new
  # GET /economy_contact_people/new.xml
  def new
    @economy_contact_person = EconomyContactPerson.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @economy_contact_person }
    end
  end

  # GET /economy_contact_people/1/edit
  def edit
    @economy_contact_person = EconomyContactPerson.find(params[:id])
  end

  # POST /economy_contact_people
  # POST /economy_contact_people.xml
  def create
    @economy_contact_person = EconomyContactPerson.new(params[:economy_contact_person])

    respond_to do |format|
      if @economy_contact_person.save
        flash[:notice] = 'EconomyContactPerson was successfully created.'
        format.html { render :action => "show", :id => @economy_contact_person.id }
        format.xml  { render :xml => @economy_contact_person, :status => :created, :location => @economy_contact_person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @economy_contact_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /economy_contact_people/1
  # PUT /economy_contact_people/1.xml
  def update
    @economy_contact_person = EconomyContactPerson.find(params[:id])

    respond_to do |format|
      if @economy_contact_person.update_attributes(params[:economy_contact_person])
        flash[:notice] = 'EconomyContactPerson was successfully updated.'
        format.html { render :action => "show", :id => @economy_contact_person.id }
        format.xml  { head :ok }
      else
        flash[:notice] = 'The update was unsuccessfull'
        format.html { render :action => "show", :id => @economy_contact_person.id }
        format.xml  { render :xml => @economy_contact_person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /economy_contact_people/1
  # DELETE /economy_contact_people/1.xml
  def destroy
    @economy_contact_person = EconomyContactPerson.find(params[:id])
      @economy_contact_person.deleted = 1
      @economy_contact_person.save

    respond_to do |format|
      format.html { render :controller => "economy_contact_units", :action => "show", :id => @economy_contact_person.economy_contact_unit_id }
      format.xml  { head :ok }
    end
  end
end
