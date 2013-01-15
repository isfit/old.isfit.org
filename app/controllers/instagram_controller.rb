class InstagramController < ApplicationController
	before_filter :cors_preflight_check
	after_filter :cors_set_access_control_headers

	caches_page :map

	def cors_set_access_control_headers
	  headers['Access-Control-Allow-Origin'] = '*'
	  headers['Access-Control-Allow-Methods'] = 'GET'
	  headers['Access-Control-Max-Age'] = "1728000"
	end

	# If this is a preflight OPTIONS request, then short-circuit the
	# request, return only the necessary headers and return an empty
	# text/plain.

	def cors_preflight_check
	  if request.method == :options
	    headers['Access-Control-Allow-Origin'] = '*'
	    headers['Access-Control-Allow-Methods'] = 'GET'
	    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
	    headers['Access-Control-Max-Age'] = '1728000'
	    render :text => '', :content_type => 'text/plain'
	  end
	end
	
	def index
    redirect_to instagram_map_path
  	end

	def map
		@liste = []
		hash = ["isfit","isfit2013","tradeyourideas"]

		hash.each do |tag|
			tags = Instagram.tag_recent_media(tag, :access_token =>"243186201.1fb234f.bb46792029d849d4ac1ede4d35ce6abc")
			tags.data.each do |obj|
				if obj.location != nil
					@liste.push(obj)
				end
			end
		end
		render :json => @liste
		
	end
end
