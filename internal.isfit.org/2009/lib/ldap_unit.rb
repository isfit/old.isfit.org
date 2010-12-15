require 'ldap_record'
require 'ldap_user'
require 'ldap_group'

# Represents and organizational unit
class LdapUnit < LdapRecord

	@@units = nil

	# Authenticates the specified credentials, searching for a user
	# entity with the specified username in either just the base entity 
	# represented by the specified base URL or its subtree as well, 
	# depending on the specified recursivity, before finally attempting to
	# bind to the LDAP server using the user entity DN and the specified  
	# passord. 
	#
	# The base URL is expected in the format isfit09/economy/it.
	def self.authenticate(base_url, recursive, username, password)
		unless self.bound?
			self.bind
		end

		# Transform base URL to LDAP DN.
		base_dn = 'ou='
		base_url.split('/').reverse.each do |element|
			base_dn = "#{base_dn}#{element},ou="
		end
		base_dn = "#{base_dn}units,dc=isfit,dc=org"

		user = nil

		# Search for entity with the given username.
		@@conn.search(base_dn, recursive ? LDAP::LDAP_SCOPE_SUBTREE :
			LDAP::LDAP_SCOPE_ONELEVEL, "uid=#{username}") do |member_entity|
				user = LdapUser.get_by_dn(member_entity.get_dn())
			end

		# Check if a user DN was found.
		if user then
			self.unbind

			begin
				if self.bind(user.dn, password) then
					return user
				end
			rescue LDAP::ResultError
				# No need to handle error, just need to shut it up.
			end
		end

		nil
	end

	# Return the parent unit
	def parent
		LdapUnit.get_by_dn(dn.split(',')[1..-1].join(','))
	end

	# Returns a list of the top level units.
	def self.units
		unless self.bound?
			self.bind
		end
		unless @@units
			@@units = self.search("ou=units,dc=isfit,dc=org", false,
				"objectClass=organizationalUnit")
		end
		@@units
	end

	# Returns a list of units contained in the current unit.
	def units
		unless @units
			@units = self.class.search(@dn, false,
				"objectClass=organizationalUnit", ['ou', 'description'])
		end
		@units
	end

	# Returns a list of functionaries contained in the current unit.
	def functionaries(recursive = false)
		unless @functionaries
			@functionaries = LdapUser.search(@dn, recursive,
				"objectClass=inetOrgPerson", ['cn', 'givenName', 'sn', 'title',
					'employeeNumber', 'uid', 'telephoneNumber'], "sn")
		end
		@functionaries
	end

	# Returns the name of the current unit.
    def name
		@attrs["ou"].first
    end

	# Sets the name of the current unit.
    def name=(value)
        @attrs["ou"] = [value]
    end

	# Returns the description of the current unit.
	def description
		@attrs["description"].first
	end

	# Sets the description of the current unit.
	def description=(value)
		@attrs["description"] = [value]
	end

	# Returns the group owned by the current unit.
	def group
		groups = LdapGroup.search("ou=groups,dc=isfit,dc=org", true,
			"(&(objectClass=posixGroup)(owner=#{dn}))")

		unless groups.empty?
			groups.first
		else
			nil
		end
	end

end
