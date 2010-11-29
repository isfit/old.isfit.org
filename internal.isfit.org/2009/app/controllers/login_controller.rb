require "ldap_unit"

class LoginController < ApplicationController
    skip_filter :authenticate, :authorize

	def index
	end

    def logout
        reset_session
        redirect_to :controller => 'article'
    end
end
