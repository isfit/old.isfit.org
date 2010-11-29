class FormController < ApplicationController

	def index
		redirect_to :action => "voucher"
	end

	def voucher
		@user = current_user

		if request.post? then
			usages = {}
			params[:voucher].keys.each do |key|
				if key =~ /amount\d+|description\d+/ then
					usages[key] = params[:voucher][key]
				end
			end
			params[:usages] = usages
			@sum = 0.0

			for i in 1..((params[:usages].size / 2)  )
				@sum += params[:usages]["amount#{i}"].sub(/,/, '.').to_d
			end

			render(:template => 'print/voucher', :layout => 'print')
		else
			@units = LdapUnit.get_by_dn(
				"ou=isfit09,ou=units,dc=isfit,dc=org").units
		end
	end

	def travel
		@user = current_user

		if request.post? then
			usages = {}
			params[:travel].keys.each do |key|
				if key =~ /date\d+|route\d+|means\d+|amount\d+/ then
					usages[key] = params[:travel][key]
				end
			end
			params[:carriers] = usages
			@sum = 0.0
			for i in 1..(params[:carriers].size / 4)
				@sum += params[:carriers]["amount#{i}"].sub(/,/, '.').to_d
			end
			
			render(:template => 'print/travel', :layout => 'print')
		else
			@units = LdapUnit.get_by_dn(
				"ou=isfit09,ou=units,dc=isfit,dc=org").units
		end
	end
end
