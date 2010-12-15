class Position < ActiveRecord::Base
	belongs_to :group
       
        def self.find_all_active_positions_alfa
          positions = Position.find_all_by_admission_id(1, :order => "title_no")
        end




#	has_many :applicants
#
#	def getApplicants
#		Applicant.find(:all, 
#			:conditions => "position_id = #{self.id} AND deleted = 0",
#			:order => "lastname asc, firstname asc")
#	end

end
