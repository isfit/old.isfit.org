class ContactController < ApplicationController
  
  helper :sort
  include SortHelper

  # INDEX = Default Action
  def index
    sort_init 'contacts.id'
    sort_update

    # Build Conditions
    if(params[:query] and (params[:query] !="") )
      @query = params[:query].split(' ')
      @search_cond = "AND ("
      or_str = ""

      @query.each do |q|
        @search_cond += or_str + "first_name LIKE '%"+q+"%' OR "
        @search_cond += "last_name LIKE '%"+q+"%' OR "	
        @search_cond += "organization LIKE '%"+q+"%'"
        or_str = "OR "
      end

      @search_cond += ")"

      # Save as a session. This is to overcome pagination limitaions...
      session[:search_cond] = @search_cond
      @query = params[:query]
    else params[:query] == ""
      session[:search_cond] = ""
    end

    # Retrieve contacts
    @contacts = Contact.paginate(
      :page => params[:page], 
      :order => sort_clause, 
      :conditions => "`delete` = 0 #{session[:search_cond]}")

    # Check if Contact EULA is read
    @read_eaula = false
	if Functionary.exists?(:id => current_user.id)
      func = Functionary.find(current_user.id)
      @read_eula = func.read_contact_eula
    end 

  end
  
  # Add a new comment to a contact
  def comment_edit
    if request.post?
      @comment = Comment.new(params[:comment])
      @comment.registered_time = DateTime.now
      if @comment.save
        redirect_to :action => "add", :id => params[:id]
      else 
        flash[:warnings] = @contact.errors
      end
    end
  end
  
  # Add read EULA on current user
  def eula_read 
	# Find functionary from db
    
	func = nil
	if Functionary.exists?(:id => current_user.id)
      func = Functionary.find(current_user.id)
      if (!func.read_contact_eula)
        func.read_contact_eula = true
      else 
        func.read_contact_eula = false
      end
    else 
      func = Functionary.new()
	  func.id = current_user.id
      func.read_contact_eula = 1
    end 
	func.save(false)
	
	redirect_to :action => "index"
  end

  # Add current user as "in touch"
  def add_me
    if params[:id]
      @cont_resp = Contact_responsible.new(
        :contact_id => params[:id],
        :responsible_id=>current_user.id)
      
      if @cont_resp.save
        redirect_to :action => "add", :id => params[:id]
      else 
        flash[:warnings] = @contact.errors
      end
    end
  end

  def remove_me
    if params[:id]
      Contact_responsible.delete_all("contact_id =#{params[:id]} and 
        responsible_id=#{current_user.id}")
      
      redirect_to :action => "add", :id => params[:id]
    end
  end

  # ADD or EDIT a new contact
  def add
    @access_granted = true
    # Henter LdapUnit-objekt for møtegjengen
    gjeng = LdapUnit.get_by_dn("ou=isfit09,ou=units,dc=isfit,dc=org")
    
    # Henter array med alle funker (LdapUser-objekter) fra gjengen
    @functionaries = gjeng.functionaries(true)
    @funker = @functionaries.sort do |a, b|
      a.lastname <=> b.lastname
    end

    # Henter en liste over alle land
    @countries = Country.find(:all, :order=>"name")

    # If we receive an id, we should edit a user, and need to fetch this user
    # from the database
    if params[:id] 
      @user = current_user
      @contact = Contact.find(params[:id]) 

      # Verify that the user has access to read contact-information.
      # If contact.staus = "Kontakt isfit ansvarlig" only the repsonsible 
      # user got access.
      if @contact.status == "Kontakt isfit ansvarlig" and 
          Integer(@contact.isfit_responsible) != @user.id
        @access_granted = false
      end
				
      @contact_via = Contact.find(
        :all,
        :conditions=> "id IN(SELECT contact_via_id FROM contact_relations
        WHERE contact_id = #{@contact.id})")
      
      @comments = Comment.find(:all,:conditions=>"contact_id =#{@contact.id}")
      @responsible = LdapUser.get_by_id(@contact.isfit_responsible)
      @contact_responsibles = Contact_responsible.find(
        :all,
        :conditions => "contact_id = #{@contact.id}")
    end
    
    # ADD new user
    if request.post?
      @contact = Contact.new(params[:contact])
      if  @contact.save
        redirect_to :action => "index"
      else
        flash[:warnings] = @contact.errors
      end
    end
  end
 
  # UPDATE an existing contact    
  def update      
    @contact = Contact.find(params[:id])   
    @contact.attributes = params[:contact]
    
    #Save
    if  @contact.save
      redirect_to :action => "add", :id=>params[:id]
    else
      redirect_to :action => "add", :id=>params[:id]
      flash[:warnings] = @contact.errors
    end
  end     

  # DELETE - delete a contact    
  def destroy      
    @contact = Contact.find(params[:id])
    if current_user.id == Integer(@contact.isfit_responsible)
      @contact.delete = 1
      @contact.save
    end
    
    redirect_to :action => "index"
  end  

  # Update contact relations
  def contact_relation
    @contact = Contact.find(params[:id])      
    @contacts = Contact.find(
      :all,
      :conditions=>"id!=#{@contact.id} and `delete` = 0")
    
    @relations_via = Contact_relation.find(
      :all,
      :conditions=>"contact_id =#{@contact.id}")
    
    # new relations received?
    if request.post?
      @contact_id = params[:id]
      @contact_via = params[:contact_via]
      
      # first remove all prev. relations
      Contact_relation.delete_all("contact_id =#{@contact_id}")
      if(@contact_via)	
        @contact_via.each do |cont| 
          @cont_rel = Contact_relation.new(
            :contact_id => @contact_id, 
            :contact_via_id=>cont)
          
          @cont_rel.save	
        end
      end		
      redirect_to :action => "add", :id=>params[:id]
    end
  end

end
