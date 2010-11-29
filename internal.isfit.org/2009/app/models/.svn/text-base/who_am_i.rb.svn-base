class WhoAmI < ActiveRecord::Base
	
	def self.get_random_functionaries
		random_functionary_ids = []
		random_functionaries = []

		isfit09 = LdapUnit.get_by_dn("ou=isfit09,ou=units,dc=isfit,dc=org")
		functionaries = isfit09.functionaries(true)

		while random_functionary_ids.length < 5
			functionary = functionaries[rand(functionaries.size)]
      func = LdapUser.get_by_dn(functionary.dn)
      if random_functionaries.empty? and
        FileTest.exists?("images/profile_images/#{functionary.id}.jpg")
        
          random_functionary_ids.push(func.id)
          random_functionaries.push(func)
      end
     
     if random_functionaries.length > 0
      
      	 if func.gender.to_i == random_functionaries[0].gender.to_i and
          not random_functionary_ids.include?(functionary.id) and 
				  FileTest.exists?("images/profile_images/#{functionary.id}.jpg")
       
				  random_functionary_ids.push(func.id)
				  random_functionaries.push(func)
				end  
      end 
    end

		return random_functionaries
	
  end
end