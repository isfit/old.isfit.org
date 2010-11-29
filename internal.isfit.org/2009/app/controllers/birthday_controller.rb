class BirthdayController < ApplicationController

	def index
		current_month = Date.today.month
		next_month = current_month == 12 ? 1 : current_month + 1
		after_next_month = next_month == 12 ? 1 : next_month + 1

		@users = LdapUser.search("ou=isfit09,ou=units,dc=isfit,dc=org", true,
			# Filter users born in current or the two following months
			# (based on string matching and dates represented as mmddyyyy)
			"(|
				(dateOfBirth=#{current_month.to_s.rjust(2, '0')}*)
				(dateOfBirth=#{next_month.to_s.rjust(2, '0')}*)
				(dateOfBirth=#{after_next_month.to_s.rjust(2, '0')}*)
			)",
			# Return first name, last name and date of birth
			[
				LdapUser::UserFirstNameAttribute,
				LdapUser::UserLastNameAttribute,
				LdapUser::UserDateOfBirthAttribute
			], 
			# Order result by date of birth 
			# (MM-DD-YYYY representation means ordering by month followed by day)
			LdapUser::UserDateOfBirthAttribute)

		@users = @users.delete_if do |u|
			u.date_of_birth.month == Date.today.month and
				u.date_of_birth.day < Date.today.day
		end

		@users = @users.sort do |a,b|    
    
			if (a.date_of_birth.month - b.date_of_birth.month).abs > 5
				b.date_of_birth.month <=> a.date_of_birth.month 
			else if (a.date_of_birth.month <=> b.date_of_birth.month) == 0
        a.date_of_birth.day <=> b.date_of_birth.day
      else
				a.date_of_birth.month <=> b.date_of_birth.month
		  end
      
    end
		end
	end
	
	def birthdaybox
		
		@users = LdapUser.search("ou=isfit09,ou=units,dc=isfit,dc=org", true, "objectClass=inetOrgPerson", 
			["sn", "dateofbirth", "givenname"])
				
		@users = @users.delete_if do |x|
			x.firstname == nil || x.date_of_birth == nil || x.lastname == nil
		end
			
		@users = @users.sort do |a,b|
			
			if (a.lastname <=> b.lastname) == 0
				a.firstname <=> b.firstname
			else
				a.lastname <=> b.lastname
			end
		end
	
	end
	
	def test
	
	end	
end
