class UnitController < ApplicationController

	def index
		redirect_to :action => "show"
	end

	def show
		unless params.include?(:id)
			params[:id] = "ou=isfit11,ou=units,dc=isfit,dc=org"
		end

		if request.post? and params[:query] and params[:query] != ""

			@search = true
			@query = create_query(params[:query])
						
			@functionaries = LdapUser.search(params[:id], true, @query, ['givenName', 'sn', 'title',
					'employeeNumber', 'uid'])
			
			@query = params[:query]
			
		else
			@search = false
		end

		@unit = LdapUnit.get_by_dn(params[:id])
	end

	def add
		if params[:id].empty?
			redirect_to :action => "index"
		else
			@unit = LdapUnit.get_by_dn(params[:id])
		end
	end
	
	def adding(a,b)
		text = "|("+a+")(cn=*"+b+"*)"	
		
		return text
	end
	
	def find_person(words)
		
		if(words.length == 1)
			return "(&(objectClass=inetOrgPerson)(cn=*" + words[0] + "*))"

		end
		
		words[0] = "cn=*"+words[0]+"*"
	
		while(words.length > 1)
			words[0] = adding(words[0],words[1])	
			words.delete_at(1)
	
		end
	
		request = "(&(objectClass=inetOrgPerson)(" + words[0] + "))"
	
		return request
	end
	
	# this method checks the search string to determine if it's a name or number
	def create_query(words)
		# check if input is a phone number
		
		if(words =~ /.*\d.*/)
			
			if words["+47"] != nil
				words = words[3..-1]
			end
			return "(&(objectClass=inetOrgPerson)(telephoneNumber=*" + words + "*))"
		end
			
		
		# input is a string 	
		
		return find_person(words.split) 
	end

	def search
		if !params[:query].empty?
			
			@users = []
			@query = create_query(params[:query])
			
			@users = LdapUser.search(params[:id], true, @query, ['givenName', 'sn', 'title',
					'employeeNumber', 'uid'])
			
			
			
		end
	end
end

