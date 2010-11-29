require 'ldap_record'
require 'ldap_user'

class LdapGroup < LdapRecord
	@@groups = nil

	def self.get_by_id(id)
		groups = self.search("ou=groups,dc=isfit,dc=org", true, 
			"(&(objectClass=posixGroup)(gidNumber=#{id}))")
		unless groups.empty?
			groups.first
		else
			nil
		end
	end

	def self.get_by_owner(owner)
		groups = self.search("ou=groups,dc=isfit,dc=org", true, 
			"(&(objectClass=posixGroup)(owner=#{owner}))")
		unless groups.empty?
			groups.first
		else
			nil
		end
	end

	def self.groups
		unless @@groups
			@@groups = self.search("ou=groups,dc=isfit,dc=org", false, 
				"objectClass=posixGroup")
		end
		@@groups
	end

	def groups
		unless @groups
			@groups = self.class.search(@dn, false, "objectClass=posixGroup")
		end
		@groups
	end

	def primary_members
		unless @primary_members
			@primary_members = LdapUser.search("dc=isfit,dc=org", true, 
			"(&(objectClass=posixAccount)(gidNumber=#{id}))")
		end

		@primary_members
	end

	def secondary_members
		unless @secondary_members
			@secondary_members = []
			if @attrs.has_key?("memberUid") and not @attrs["memberUid"].empty?
				@attrs["memberUid"].each do |username|
					users = LdapUser.search("dc=isfit,dc=org", true,
						"uid=#{username}")
					unless users.empty?
						@secondary_members.push(users.first)
					end
				end
			end
		end

		@secondary_members
	end

	def virtual_members
		unless @virtual_members
			@virtual_members = []
			if @attrs.has_key?("uniqueMember") and not @attrs["uniqueMember"].empty?
				@attrs["uniqueMember"].each do |dn|
					user = LdapUser.get_by_dn(dn)
					if user
						@virtual_members.push(user)
					end
				end
			end
		end
		@virtual_members
	end

	def name
		@attrs["cn"].first
	end

	def name=(value)
		@attrs["cn"] = [value]
	end

	def id
		@attrs["gidNumber"].first
	end

	def id=(value)
		@attrs["gidNumber"] = [value.to_s]
	end

	def mails
		if @attrs.has_key?("mail")
			@attrs["mail"]
		else
			[]
		end
	end

	def mails=(value)
		@attrs["mail"] = value
	end

end
