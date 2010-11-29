class UserController < ApplicationController

	def index
	end

	def show
		@user = LdapUser.get_by_dn(params[:id])
	end



	 
	 
  def impersonate
		if request.post?
			user = LdapUser.get_by_username(params[:user][:username])
			initialize_session(user)
			redirect_to :action => :edit
		end
	end

	def edit
		def validate
			@user.valid?
			unless params[:new_password] == ''
				unless LdapUser.valid_password?(params[:new_password])
					@user.errors.add(:new_password, 'Invalid new password. ' +
						'Password must be at least 8 characters long ' +
						'containing both uppercase (A-Z) and lowercase (a-z) ' +
						'letters as well as digits (0-9).')
				end
			end
			unless params[:verify_password] == params[:new_password]
				@user.errors.add(:veriy_password, 'Passwords don\'t match.')
			end
			@user.errors.empty?
		end

		@user = current_user
		if Functionary.exists?(:id => current_user.id)
		  @func = Functionary.find(current_user.id)
		else
      @func = Functionary.new(params[:current_user.id])
		  @func.id = current_user.id
		end
		if request.post? then
			@user.errors.add("HIT")
			@func.errors.add("HIT")
      @user.errors.add("HIT")
			@user.attributes = params[:user]
		  @func.attributes = params[:func]
			unless params[:new_password] == ''
				@user.password = params[:new_password]
				@user.samba_account_password = params[:new_password] if
					@user.has_samba_account?
			end
			unless (params.has_key?(:password) and \
				LdapAccessList.authenticate('internal11', 'everyone',
				@user.username, params[:password]) != false)
				# Validate input, and add invalid password message
				validate
				@user.errors.add(:password, 'Your authorization failed: Invalid password.')

				flash[:warnings] = @user.errors
			else
				if validate and @user.save and @func.save
      #  if @func.save
					current_user = LdapUser.get_by_dn(@user.dn)
					unless params[:image] == ""
						path = "#{RAILS_ROOT}/public/images/profile_images/" +
							"#{current_user.id}.jpg"
						@picture = Picture.new(path, params[:image],400)
						@picture.save
					end
					redirect_to :action => 'show', :id => current_user.dn
				else
					flash[:warnings] = @user.errors
					flash[:warnings] = @func.errors
				end
			end
		else
			flash[:warnings] = nil
		end
	end

	def modify
		@user = LdapUser.get_by_id(params[:id])
  	end
	
  	def list
		if request.post? and params[:details_data]
			values = {}
			params[:details_data].each do |k,v|
				parts = k.split("_")
				type = parts[0]
				id = parts[1].to_i
				values[id] = {} unless values.include?(id)
				values[id][type] = v
			end
			values.each do |k,v|
				if Functionary.exists?(k)
					f = Functionary.find(k)
				else
					f = Functionary.new
					f.id = k
				end
				params[:k0k0] = v if k == 55
				f.cardnumber_ntnu = v["ntnu"]
				f.cardnumber_isfit = v["isfit"]
				f.cardnumber_samfundet = v["samfundet"]
				f.save(false)
			end
		end

    		@admin = LdapUnit.get_by_dn("ou=administration,ou=isfit09,ou=units,dc=isfit,dc=org")
    		@cult = LdapUnit.get_by_dn("ou=culture,ou=isfit09,ou=units,dc=isfit,dc=org")
    		@eco = LdapUnit.get_by_dn("ou=economy,ou=isfit09,ou=units,dc=isfit,dc=org")
    		@pr = LdapUnit.get_by_dn("ou=pr,ou=isfit09,ou=units,dc=isfit,dc=org")
    		@proj = LdapUnit.get_by_dn("ou=project,ou=isfit09,ou=units,dc=isfit,dc=org")
    		@theme = LdapUnit.get_by_dn("ou=theme,ou=isfit09,ou=units,dc=isfit,dc=org") 
    
		@details = {}
		details = Functionary.find_by_sql("SELECT * FROM `functionaries` ")
		details.each do |d|
			@details[d.id] = d
		end
  	end

	def print
		@functionaries = LdapUser.search("ou=isfit09,ou=units,dc=isfit,dc=org",
			true, "objectClass=inetOrgPerson", nil, "sn")

		render(:template => "user/print", :layout => "print")
	end
	
	def allergie
		if params[:allergie] == "1"
			@functionaries_allergie = Functionary.find(:all, :conditions => "no_allergies = 0 and vegetarian = 1")
		elsif params[:allergie] == "2"
			@functionaries_allergie = Functionary.find(:all, :conditions => "no_allergies = 0 and lactose = 1")
		elsif params[:allergie] == "3"
			@functionaries_allergie = Functionary.find(:all, :conditions => "no_allergies = 0 and gluten = 1")
		elsif params[:allergie] == "4"
			@functionaries_allergie = Functionary.find(:all, :conditions => "no_allergies = 0 and nut_allergy = 1")
		elsif params[:allergie] == "5"
			@functionaries_allergie = Functionary.find(:all, :conditions => "no_allergies = 0 and fruit = 1")
		elsif params[:allergie] == "6"
			@functionaries_allergie = Functionary.find(:all, :conditions => "no_allergies = 0 and not other is NULL ")
		else
			@functionaries_allergie = Functionary.find(:all, :conditions => "no_allergies = 0")
		end
		@allergies = find_allergies(@functionaries_allergie)
		#render(:template => 'user/allergie', :layout => 'print')
		
	end
	
	
	def find_allergies(current_eaters)
		allergies_for_meal = {}
		current_eaters.each do |current_eater|
			allergies_for_meal[current_eater.id] = []
			if current_eater.vegetarian == 1
				allergies_for_meal[current_eater.id].push("X")
			else
				allergies_for_meal[current_eater.id].push(" ")
			end
			if current_eater.lactose == 1
				allergies_for_meal[current_eater.id].push("X")
			else
				allergies_for_meal[current_eater.id].push(" ")
			end
			if current_eater.gluten == 1
				allergies_for_meal[current_eater.id].push("X")
			else
				allergies_for_meal[current_eater.id].push(" ")
			end
			if current_eater.nut_allergy == 1
				allergies_for_meal[current_eater.id].push("X")
			else
				allergies_for_meal[current_eater.id].push(" ")
			end
			if current_eater.fruit == 1
				allergies_for_meal[current_eater.id].push("X")
			else
				allergies_for_meal[current_eater.id].push(" ")
			end
			if current_eater.other != ""
				allergies_for_meal[current_eater.id].push(current_eater.other)
			else
				allergies_for_meal[current_eater.id].push(" ")
			end
		end
		
		return allergies_for_meal
	
	end
	
	def skilist
				@functionaries_skies = Functionary.find(:all, :conditions => "has_skies = 1")
					
        @shoesizes = {} 
        			
        @functionaries_skies.each do |f|
          if @shoesizes.include?(f.shoe_size)
             @shoesizes[f.shoe_size]+=1
          else
            @shoesizes[f.shoe_size]=1 
          end
        end  
  end        
	
	def info
		@admin = LdapUnit.get_by_dn("ou=administration,ou=isfit09,ou=units,dc=isfit,dc=org")
		@cult = LdapUnit.get_by_dn("ou=culture,ou=isfit09,ou=units,dc=isfit,dc=org")
	    	@eco = LdapUnit.get_by_dn("ou=economy,ou=isfit09,ou=units,dc=isfit,dc=org")
	    	@pr = LdapUnit.get_by_dn("ou=pr,ou=isfit09,ou=units,dc=isfit,dc=org")
	    	@proj = LdapUnit.get_by_dn("ou=project,ou=isfit09,ou=units,dc=isfit,dc=org")
	    	@theme = LdapUnit.get_by_dn("ou=theme,ou=isfit09,ou=units,dc=isfit,dc=org") 
	    
		@details = {}
		details = Functionary.find_by_sql("SELECT * FROM `functionaries` ")
		details.each do |d|
			@details[d.id] = d
		end
		
		
		render(:template => 'user/info', :layout => 'print')

	end  
end
