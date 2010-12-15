module EconomyContactLogsHelper
	def self.can_access?(controller, action)
		request_action = {:controller => controller, :action => action}
		request_controller = {:controller => controller, :action => '*'}
		all = {:controller => '*', :action => '*'}

		session[:access].include?(request_action) or 
			session[:access].include?(request_controller) or
			session[:access].include?(all)
	end


  def self.has_access_to_edit
    self.can_access?('economy_contact_logs', 'edit_all') 
  end
end
