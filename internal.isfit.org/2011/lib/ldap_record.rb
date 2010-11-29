require 'ldap'
require 'rubygems'
require 'active_record'

# Represents an LDAP entity, allowing reading and writing its attributes.
class LdapRecord

	@@conn = nil
	@dn = nil
	@attrs = {}
	@errors = nil
  
private
	# Creates a new LDAP record with the given DN and set of attributes.
	def initialize(dn, attrs)
		@dn = dn
		attrs.delete("dn")
		@attrs = attrs
		@updated_attrs = {}
		@errors = ActiveRecord::Errors.new(self)
	end

public
	# Binds the class statically to the localhost LDAP server with the given
	# bind DN and password.
	#
	# The resulting connection may be used by all derived classes.
	def self.bind(dn = nil, password = nil)
		tries = 5

		while tries > 0
			old_follow_aliases = follow_aliases unless @@conn == nil

			@@conn = LDAP::Conn.new("localhost")
			@@conn.set_option(LDAP::LDAP_OPT_PROTOCOL_VERSION, 3)
			
			self.follow_aliases = old_follow_aliases or :always

			begin
				if dn != nil and password != nil
					return @@conn.bind(dn, password)
				else
					return @@conn.bind
				end
			rescue LDAP::ResultError
				tries = tries - 1
				sleep 0.2
			end
		end

		false
	end

	def self.follow_aliases
		case @@conn.get_option(LDAP::LDAP_OPT_DEREF)
		when 0
			:never
		when 1
			:searching
		when 2
			:finding
		when 3
			:always
		end
	end

	def self.follow_aliases=(value)
		opt = nil
		case value
		when :never
			opt = 0
		when :searching
			opt = 1
		when :finding
			opt = 2
		when :always
			opt = 3
		end
		@@conn.set_option(LDAP::LDAP_OPT_DEREF, opt) if opt != nil
	end

	# Unbinds the class from the LDAP server.
	def self.unbind
		@@conn.unbind
		@@conn = LDAP::Conn.new("localhost")
	end

	# Checks whether or not the class is bound to the LDAP server.
	def self.bound?
		unless @@conn == nil
			@@conn.bound?
		else
			false
		end
	end

	# Returns the static class LDAP connection.
	def self.connection
		@@conn
	end

	# Searches in base, recursive or not, for entities matching the given
	# filter, and returns a list of object instances of the current class
	# representing the matching entities.
	def	self.search(base, recursive = false, filter = "objectClass=*",
		attrs = nil, sort_attribute = "", sort_proc = nil)
		bind unless bound?

		records = []
		begin
			@@conn.search(base, recursive ? LDAP::LDAP_SCOPE_SUBTREE :
				LDAP::LDAP_SCOPE_ONELEVEL, filter, attrs, false, 0, 0,
				sort_attribute, sort_proc) do |entry|
				record = self.new(entry.get_dn, entry.to_hash)
				
				records.push(record)
		end
		rescue RuntimeError
			# Just shut it up
		end

		records
	end

	# Looks up the given DN and returns an object instance of the current class
	# representing the referenced entity.
	def self.get_by_dn(dn)
		bind unless bound?
		@@conn.search(dn, LDAP::LDAP_SCOPE_BASE, "objectClass=*") do |entry|
			return self.new(entry.get_dn, entry.to_hash)
		end
		nil	
	end

	# Determines whether or not the given DN exists.
	def self.exists?(dn)
		bind unless bound?
		@@conn.search(dn, LDAP::LDAP_SCOPE_BASE, "") do |entry|
			return true
		end
		false
	end

	# Returns the represented DN.
	def dn
		@dn
	end
    
	# Returns a list of attribute values associated by the given attribute
	# key.
	def [](key)
		@attrs.each_key do |k|
			if k.casecmp(key) then
				key = k
			end
		end

		@attrs[key]
	end

	# Sets a list of attribute values to be associated by the given attribute
	# key.
	def []=(key, value)
		@attrs.each_key do |k|
			if k.casecmp(key) then
				key = k
			end
		end

		@attrs[key] = value
	end

	def attributes=(value)
		@updated_attrs = value
	end

	# Saves the current represented entity, creating all necessary attributes
	# including the entity itself.
	def save
		attrs = {}
		exists = false

		# Determine if entity alread exists
		begin
			@@conn.search(dn, LDAP::LDAP_SCOPE_BASE, "objectClass=*") do |entry|
				attrs = entry.to_hash
			end
			exists = true
		rescue LDAP::ResultError
			# Ignore silently, now we know the entity doesn't exist
		end

		mods = []

		# Iterate new attributes, looking for changes
		@attrs.each do |key, values|
			# Remote empty values
			values.delete_if do |value|
				value.nil? or (value.kind_of?(String) and value.strip.empty?)
			end

			# Convert values to strings
			values.map! do |v| v.to_s end

			if not attrs.has_key?(key) and not values.empty?
				mods.push(LDAP::Mod.new(LDAP::LDAP_MOD_ADD, key, values))
			elsif attrs.has_key?(key) and not values.empty? and not 
				attrs[key].eql?(values) 
				
				mods.push(LDAP::Mod.new(LDAP::LDAP_MOD_REPLACE, key, values))
			elsif attrs.has_key?(key) and values.empty?
				mods.push(LDAP::Mod.new(LDAP::LDAP_MOD_DELETE, key, []))
			end
		end

		unless mods.empty?
			if exists
				unless @@conn.modify(dn, mods)
					return false
				end
			else
				unless @@conn.add(dn, mods)
					return false
				end
			end
		end

		return @errors.empty?
	end

	# Snatched from the Ruby On Rails Inflector module, to do word camelization
	# (transform underscore_word to underscoreWord).
	def self.camelize(lower_case_and_underscored_word, 
		first_letter_in_uppercase = true)
		if first_letter_in_uppercase
			lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::" + 
				$1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
		else
			lower_case_and_underscored_word.to_s[0..0] + 
				camelize(lower_case_and_underscored_word)[1..-1]
		end
	end

	# Returns the Error object containing validation errors generates during
	# saving
	def errors
		@errors
	end
  
end
