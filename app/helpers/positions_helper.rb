module PositionsHelper
	def selected_first_position
		@referral_position || @applicant.position_id_1 || nil
	end
end