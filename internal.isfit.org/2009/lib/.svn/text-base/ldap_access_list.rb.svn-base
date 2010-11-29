require 'ldap_record'
require 'ldap_user'

class LdapAccessList < LdapRecord

	@@categories = nil

	def self.get_member_user(category, list, username, user_dn)
		# If not already bound, bind anonymously
		bind unless bound?

		# Build DN for the specified categorized list
		access_list_dn = 'cn=' + list + ',ou=' + category +
			',ou=accesslists,dc=isfit,dc=org'

		access_list = LdapAccessList.get_by_dn(access_list_dn)
		user = nil

		access_list.member_urls.each do |member_url|
			member_url =~ /^ldap:\/\/\/([^?]*)(\?([^?]*)(\?([^?]*)(\?([^?]*))?)?)?/

			base_dn = $~[1]
			attribute = $~[3]
			scope = $~[5]
			filter = $~[7]

			scope = "base" if scope == nil or scope == ""

			if filter == nil or filter == ""
				user = LdapUser.get_by_dn(user_dn) if base_dn == user_dn
			elsif filter != nil and filter[":dn:"] and not user_dn["board"]
				follow_aliases = self.follow_aliases

				if follow_aliases != :never
					self.unbind
					self.follow_aliases = :never
					self.bind
				end

				filter = "(&(aliasedObjectName=#{user_dn})" + filter + ")"
				aliases = LdapRecord.search(base_dn, scope == "sub", filter,
					["aliasedObjectName"])

				if follow_aliases != :never
					self.unbind
					self.follow_aliases = follow_aliases
					self.bind
				end

				user = LdapUser.get_by_dn(user_dn) if aliases != []
			else
				if filter != nil
					filter = "(&(uid=#{username})" + filter + ")"
				else
					filter = "(uid=#{username})"
				end

				users = LdapUser.search(base_dn, scope == "sub", filter)
				user = users[0] if users != []
			end

			break if user != nil
		end

		user
	end

	def self.get_user_access(category, user)
		# If not already bound, bind anonymously
		self.bind unless bound?

		lists = self.search("ou=#{category},ou=accesslists,dc=isfit,dc=org",
			true, 'objectClass=groupOfURLs', ['cn', 'businessCategory'])
		access = []
		lists.each do |list|
			if LdapAccessList.get_member_user(category, list.name, 
				user.username, user.dn)
				
				access.concat(list.access)
			end
		end
		access
	end

	def self.authenticate(category, list, username, password)
		# If not already bound, bind anonymously
		self.bind unless bound?

		user = LdapUser.get_by_username(username)
		user = LdapAccessList.get_member_user(category, list, username, 
			user != nil ? user.dn : "")

		# Unbind
		self.unbind

		# Try to bind using the supplied password
		if user
			begin
				if self.bind(user.dn, password) then
					return user
				end
			rescue LDAP::ResultError
				# No need to handle error, just need to shut it up
			end
		end

		false
	end

	def self.categories
		unless @@categories
			@@categories = self.search("ou=accesslists,dc=isfit,dc=org", false,
				"objectClass=organizationalUnit", ['businessCategory',
				'cn', 'memberURL'])
		end
		@@categories
	end

	def initialize(dn, attrs)
		attrs.delete("uniqueMember")
		super(dn, attrs)
	end

	def access
		access_list = []
		if @attrs.has_key?("businessCategory")
			@attrs["businessCategory"].each do |access|
				parts = access.split('/')
				access_list.push({:controller => parts[0],
					:action => parts[1]})
			end
		end
		access_list
	end

	def name
		@attrs["cn"].first
	end

	def member_urls
		if @attrs.has_key?("memberURL")
			@attrs["memberURL"]
		else
			[]
		end
	end

end
