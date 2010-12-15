class FestivalenController < ApplicationController

	require 'scrobbler'	

	def lastfm
		@user = Scrobbler::User.new('isfit-uka')
	end

	def liv
		user = Scrobbler::User.new('isfit-uka')
		@track = user.recent_tracks[0] 
	end

	def self.is_party
		user = Scrobbler::User.new('isfit-uka')
		@track = user.recent_tracks[0]
		if @track.date > (Time.now - (60*60*2))
		return 1
		else 
		return 0
		end
	end
end
