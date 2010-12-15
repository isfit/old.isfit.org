class Answer < ActiveRecord::Base 
  belongs_to :participant, :class_name => "Participant", :foreign_key => "id"
  
  
	validates_presence_of :attend, :message =>"Please answer: 'Will you attend ISFiT 2009?'"
	validates_presence_of :visa, :message => "Please answer the Visa section."
	validates_presence_of :stay_with, :message => "Please answer: 'I prefer to stay with' under 'Accomondation'"
	validates_presence_of :smoke, :message =>"Please answer: 'Do you smoke?' under 'Accomondation'"
	validates_presence_of :handicap, :message =>"Please answer: 'Do you have a handicap or other special requirements?' under 'Accomondation'"
	validates_presence_of :handicap_description, :if => Proc.new { |f| f.handicap !=nil and  f.handicap > 0 }, :message => "Please specify your handicap"
	validates_presence_of :food_description, :if => Proc.new { |f| f.other > 0 }, :message => "Please specify your requirement"
	validates_format_of :food_description, :with => /^\s*$/, :if => Proc.new { |f| f.other == 0}, :message => "Please click the checkbox 'Other' in the Food section if you have any additional food description, or erase the text in the Food text area entirely."
	validates_format_of :handicap_description, :with => /^\s*$/, :if => Proc.new { |f| f.handicap == 0}, :message => "Please click 'Yes' under 'handicap' if you have a handicap, or erase the text in the Handicap text area entirely."
	validate :check_foodproblem
	
	#Checks if no_problem and any other food-requriment are selected at the same time
	def check_foodproblem
		errors.add_to_base("There is a conflict in the Food section: 'No special dietary needs' is checked together with one or more dietary needs.") if no_special >0 and ( (vegetarian > 0) or (lactose > 0) or (kosher > 0) or (halal > 0) or (other > 0))	
	end
	
	
	
end
