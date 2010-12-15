class Section < ActiveRecord::Base
	has_many :positions

	def self.getAll(language)
		find(:all, :order => "name_#{language} asc")
	end

	def getPositions(language)
		Position.find(:all, 
			:conditions => "section_id = #{self.id} AND deleted = 0 AND 
			NOT title_#{language} IS NULL",
			:order => "weight asc, title_en asc")
	end

	def getAllPositions(language)
		Position.find(:all, 
			:conditions => "section_id = #{self.id} AND 
			NOT title_#{language} IS NULL",
			:order => "weight asc, title_en asc")
	end

end
