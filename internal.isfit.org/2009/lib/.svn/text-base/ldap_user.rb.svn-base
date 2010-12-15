require 'ldap_record'
require 'ldap_unit'
require 'date'
require 'openssl'
require 'base64'

class LdapUser < LdapRecord

	# LDAP attribute name constants
	ObjectClassAttribute = "objectClass"

	AliasObjectClass = "alias"
	AliasedObjectAttribute = "aliasedObjectName"

	UserObjectClass= "inetOrgPerson"
	UserIdAttribute = "employeeNumber"
	UserUsernameAttribute = "uid"
	UserPasswordAttribute = "userPassword"
	UserNameAttribute = "cn"
	UserFirstNameAttribute = "givenName"
	UserLastNameAttribute = "sn"
	UserPhonesAttribute = "telephoneNumber"
	UserTitleAttribute = "title"
	UserStreetAttribute = "street"
	UserPostalCodeAttribute = "postalCode"
	UserPostalAddressAttribute = "postalAddress"
	UserDateOfBirthAttribute = "dateOfBirth"
	UserGenderAttribute = "gender"
	UserMailsAttribute = "mail"

	SystemAccountObjectClass = "posixAccount"
	SystemAccountIdAttribute = "uidNumber"
	SystemAccountGroupIdAttribute = "gidNumber"
	SystemAccountHomeDirectoryAttribute = "homeDirectory"

	SambaDomainId = "S-1-5-21-1659200514-1340900546-3664797893"
	SambaAccountObjectClass = "sambaSamAccount"
	SambaAccountPasswordAttribute = "sambaNTPassword"
	SambaAccountPasswordLastSetAttribute = "sambaPwdLastSet"
	SambaAccountIdAttribute = "sambaSID"

	# Class functions

    def self.get_by_id(id)
        users = self.search("dc=isfit,dc=org", true,
            "(&(#{ObjectClassAttribute}=#{UserObjectClass})" \
			"(#{UserIdAttribute}=#{id}))")

		unless users.empty?
			users.first
		else
			nil
		end
    end

    
    def self.get_by_username(username)
        users = self.search("dc=isfit,dc=org", true,
            "(&(#{ObjectClassAttribute}=#{SystemAccountObjectClass})" \
			"(#{UserUsernameAttribute}=#{username}))")

		unless users.empty?
			users.first
		else
			nil
		end
    end

  
	def self.valid_password?(password)
		password.length >= 8 and password =~ /[A-Z]/ and
		password =~ /[a-z]/ and password =~ /[0-9]/
	end

	# Instance functions

	# General user functions

	def initialize(dn, attrs = {ObjectClassAttribute => [UserObjectClass]})
		super(dn, attrs)
	end

	def is_in_group?(group_dn)
    self.dn[self.dn.length - group_dn.length, group_dn.length] == group_dn or
			begin
				alias_in_group = false
				aliases.each do |a|
					if a.dn[a.dn.length - group_dn.length, group_dn.length] == group_dn
						alias_in_group = true
						break
					end
				end
				alias_in_group
			end
	end

	def aliases
		follow_aliases = LdapRecord.follow_aliases
		if follow_aliases != :never
			LdapRecord.unbind
			LdapRecord.follow_aliases = :never
			LdapRecord.bind
		end
		aliases = LdapRecord.search("dc=isfit,dc=org", true,
			"aliasedObjectName=#{self.dn}")
		if follow_aliases != :never
			LdapRecord.unbind
			LdapRecord.follow_aliases = follow_aliases
			LdapRecord.bind
		end
		aliases	
	end

	def is_alias?
		@attrs[ObjectClassAttribute].include?(AliasObjectClass)
	end

	def dereference
		LdapUser.get_by_dn(@attrs[AliasedObjectAttribute].first)
	end

    def id
       	@attrs[UserIdAttribute].first.to_i
    end

    def id=(value)
        @attrs[UserIdAttribute] = [value.to_s]
    end

	def username
		if @attrs.has_key?(UserUsernameAttribute)
			@attrs[UserUsernameAttribute].first
		else
			nil
		end
	end

	def username=(value)
		@attrs[UserUsernameAttribute] = [value]
	end

	def password=(value)
		@attrs[UserPasswordAttribute] = 
			["{MD5}#{Base64::encode64(
			OpenSSL::Digest::MD5.hexdigest(value).to_a.pack("H*"))}"]
	end

	def unit
		LdapUnit.get_by_dn(dn.split(',')[1..-1].join(','))
	end

	def name
		@attrs[UserNameAttribute].first
	end

	def name=(value)
		@attrs[UserNameAttribute] = [value]
	end

	def name_reversed
		lastname + ", " + firstname
	end

	def firstname
		if @attrs.has_key?(UserFirstNameAttribute)
			@attrs[UserFirstNameAttribute].first
		else
			nil
		end
	end

	def firstname=(value)
		@attrs[UserFirstNameAttribute] = [value]
	end

	def lastname
		if @attrs.has_key?(UserLastNameAttribute)
			@attrs[UserLastNameAttribute].first
		else
			nil
		end
	end

	def lastname=(value)
		@attrs[UserLastNameAttribute] = [value]
	end

	def phones
		if @attrs.has_key?(UserPhonesAttribute)
			@attrs[UserPhonesAttribute]
		else
			[]
		end
	end

	def phones=(value)
		@attrs[UserPhonesAttribute] = value
	end
	
	def title
		if @attrs.has_key?(UserTitleAttribute)
			@attrs[UserTitleAttribute].first
		else
			nil
		end
	end

	def title=(value)
		@attrs[UserTitleAttribute] = [value]
	end

	def street
		if @attrs.has_key?(UserStreetAttribute)
			@attrs[UserStreetAttribute].first
		else
			nil
		end
	end

	def street=(value)
		@attrs[UserStreetAttribute] = [value]
	end

	def postal_code
		if @attrs.has_key?(UserPostalCodeAttribute)
			@attrs[UserPostalCodeAttribute].first
		else
			nil
		end
	end

	def postal_code=(value)
		@attrs[UserPostalCodeAttribute] = [value]
	end

	def postal_address
		if @attrs.has_key?(UserPostalAddressAttribute)
			@attrs[UserPostalAddressAttribute].first
		else
			nil
		end
	end

	def postal_address=(value)
		@attrs[UserPostalAddressAttribute] = [value]
	end

	def date_of_birth
		if @attrs.has_key?(UserDateOfBirthAttribute)
			Date.strptime(@attrs[UserDateOfBirthAttribute].first, "%m%d%Y")
		else
			nil
		end
	end

	def date_of_birth=(value)
		@attrs[UserDateOfBirthAttribute] = [value.month.to_s.rjust(2, '0') +
			value.day.to_s.rjust(2, '0') + value.year.to_s]
	end

	def gender
		if @attrs.has_key?(UserGenderAttribute)
			@attrs[UserGenderAttribute].first.to_i
		else
			0
		end
	end

	def gender=(value)
		@attrs[UserGenderAttribute] = [value]
	end

    def mails
		if @attrs.has_key?(UserMailsAttribute)
	        @attrs[UserMailsAttribute]
		else
			[]
		end
    end

    def mails=(value)
        @attrs[UserMailsAttribute] = value
    end
	
	def ==(user)
		if user.respond_to?('dn')
			dn == user.dn
		else
			false
		end
	end

	# System account functions

	def has_system_account?
		@attrs[ObjectClassAttribute].include?(SystemAccountObjectClass)
	end

	def has_system_account=(value)
		if value == true
			unless has_system_account?
				@attrs[ObjectClassAttribute].insert(0, SystemAccountObjectClass)
			end
		else
			# Clear all user account attributes
			@attrs[ObjectClassAttribute].delete(SystemAccountObjectClass)
			@attrs.delete(SystemAccountIdAttribute)
			@attrs.delete(SystemAccountGroupIdAttribute)
			@attrs.delete(SystemAccountHomeDirectoryAttribute)
			# TODO: Must handle secondary groups in some way
		end
	end

	def system_account_id
		@attrs[SystemAccountIdAttribute].first.to_i
	end

	def system_account_id=(value)
		@attrs[SystemAccountIdAttribute] = [value]
	end

	def home_directory
		if @attrs.has_key?(SystemAccountHomeDirectoryAttribute)
			@attrs[SystemAccountHomeDirectoryAttribute].first
		else
			nil
		end
	end

	def home_directory=(value)
		@attrs[SystemAccountHomeDirectoryAttribute] = [value]
	end

	def primary_group
		unless @primary_group
			@primary_group = 
				LdapGroup.get_by_id(@attrs[SystemAccountGroupIdAttribute])
		end
		@primary_group
	end

    def primary_group_id
        @attrs[SystemAccountGroupIdAttribute].first.to_i
    end

    def primary_group_id=(value)
        @attrs[SystemAccountGroupIdAttribute] = [value.to_s]
    end
	
	def secondary_groups
		unless @secondary_groups
			@secondary_groups = LdapGroup.search("ou=groups,dc=isfit,dc=org", 
				true, 
				"(&(objectClass=posixGroup)(memberUid=#{username}))")
		end
		@secondary_groups
	end

	# Samba account functions

	def has_samba_account?
		@attrs[ObjectClassAttribute].include?(SambaAccountObjectClass)
	end

	def has_samba_account=(value)
		if value == true
			# Add necessary Samba attributes
			unless has_samba_account?
				@attrs[ObjectClassAttribute].insert(0, SambaAccountObjectClass)
				@attrs[SambaAccountPasswordLastSetAttribute] = ["1"]
			end
		else
			# Clear all Samba attrributes
			@attrs[ObjectClassAttribute].delete(SambaAccountObjectClass)
			@attrs.delete[SambaAccountPasswordAttribute]
			@attrs.delete[SambaAccountPasswordLastSetAttribute]
			@attrs.delete[SambaAccountIdAttribute]
		end
	end

	def samba_account_id
		@attrs[SambaAccountIdAttribute].first
	end

	def samba_account_id=(value)
		@attrs[SambaAccountIdAttribute] = [SambaDomainId + "-" + value.to_s]
	end

	def samba_account_password=(value)
		@attrs[SambaAccountPasswordAttribute] = 
			[OpenSSL::Digest::MD4.hexdigest(value.split(//).join("\0") + 
			"\0").upcase]
	end

	# Storage functions

	def valid?
		@errors.clear
		@updated_attrs.each do |key,value|
			case key
				when "phones"
					@attrs[UserPhonesAttribute] = 
						value.split(",").collect do |no|
							no.strip
						end
				when "date_of_birth"
					begin
					if value.strip != ""
						raise ArgumentError unless 
							value =~ /^\d{2}\.\d{2}\.\d{4}$/
						@attrs[UserDateOfBirthAttribute] = 
						[Date.strptime(value, "%d.%m.%Y").strftime("%m%d%Y")]
					else
						@errors.add(:date_of_birth,
							"Date of birth must be entered.")
					end
					rescue ArgumentError
						@errors.add(:date_of_birth, 
							"\"#{value}\" is not a valid date.")
					end
				else
					@attrs[LdapRecord.camelize(key, false)] = [value.strip]
			end
		end

		# Perform validation

		# Validate phones
		if @attrs.has_key?(UserPhonesAttribute) and not 
			@attrs[UserPhonesAttribute].empty?

			@attrs[UserPhonesAttribute].each do |no|
				if (no =~ /^\+?\d+$/) == nil
					@errors.add(:phones, 
						"\"#{no}\" is not a valid phone number.")
				end
			end
		else
			@errors.add(:phones, "At least one phone number must be entered.")
		end

		# Street
		unless @attrs.has_key?(UserStreetAttribute) and 
			not @attrs[UserStreetAttribute].empty? and
			@attrs[UserStreetAttribute][0].strip != ""

			@errors.add(:street, "Street must be entered.")
		end

		# Postal code
		if not (@attrs.has_key?(UserPostalCodeAttribute) and not
			@attrs[UserPostalCodeAttribute].empty? and 
			@attrs[UserPostalCodeAttribute][0].strip != "")

			@errors.add(:postal_code, "Postal code must be entered.")
		elsif (@attrs[UserPostalCodeAttribute][0] =~ /^\d{4}$/) == nil
			@errors.add(:postal_code, 
				"\"#{@attrs[UserPostalCodeAttribute][0]}\" is not valid " \
				"postal code.")
		end

		# Postal address
		unless @attrs.has_key?(UserPostalAddressAttribute) and not
			@attrs[UserPostalAddressAttribute].empty? and 
			@attrs[UserPostalAddressAttribute][0].strip != ""
			
			@errors.add(:postal_address, "Postal place must be entered.")
		end

		# Date of birth
		unless @attrs.has_key?(UserDateOfBirthAttribute) and not
			@attrs[UserDateOfBirthAttribute].empty? and 
			@attrs[UserDateOfBirthAttribute][0].strip != ""
			
			@errors.add(:date_of_birth, "Date of birth must be entered.")
		end

		# Gender
		unless @attrs.has_key?(UserGenderAttribute) and 
			(@attrs[UserGenderAttribute][0] == "1" or
			@attrs[UserGenderAttribute][0] == "2")

			@errors.add(:gender, "Gender must be selected.")
		end

		@errors.empty?
	end
  
  def forum_posts
    ForumPost.find(:all, :conditions => "user_id = #{self.id} and deleted = 0")
  end
  
	def attributes=(value)
		@updated_attrs = value
	end
  
	def save(perform_validation = true)
		if perform_validation then
			if valid?
				super()
			else
				false
			end
		else
			super()
		end
	end

end
