class Section < ActiveRecord::Base
  self.primary_key = 'id'
  #lang_attr :name, :description
  has_many :groups

	def self.getAll(language)
		find(:all, :order => "name_#{language} asc")
	end

	def positions
		positions = []
		self.groups.each {|g| positions << g.positions.published.to_a }
    positions.flatten!
    positions.sort! do |a,b|
	    result = a.title_no.starts_with?("Nestleder") ? -1 : 0
	    if result.eql?(-1)
	      result = b.title_no.starts_with?("Nestleder") ? 0 : -1
	    else
	      result = b.title_no.starts_with?("Nestleder") ? 1 : 0
	    end
	    result =  1 if a.title_no.eql?("Prosjektansvarlig i IT")
	    result = -1 if b.title_no.eql?("Prosjektansvarlig i IT")
	    result = a.title_no <=> b.title_no if result.eql? 0
	    result
	  end
	  positions
	end

	def getPositions(language)
		Position.find(:all, 
			:conditions => "section_id = #{self.id} AND deleted = 0 AND admission_id=1 AND
			NOT title_#{language} IS NULL",
			:order => "title_en asc")
	end
	#Kan velge hvilke opptak
	def getPositions2(language,nr)
		Position.find(:all, :conditons =>"section_id = #{self.id}  AND deleted = 0 AND NOT title_#{language} IS NULL AND opptaknr = #{nr}", :order => "weight asc, title_en asc")
	end

	def description
		Language.to_s.eql?("no") ? self.description_no : self.description_en
	end

	def name
		Language.to_s.eql?("no") ? self.name_no : self.name_en
	end
end
