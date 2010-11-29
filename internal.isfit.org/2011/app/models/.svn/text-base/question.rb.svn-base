class Question < ActiveRecord::Base
	
	belongs_to :participant

	validates_presence_of :subject, :message => "Subject can't be blank"
	validates_presence_of :question, :message => "Question can't be blank"
	validates_length_of :subject, :maximum => 50, :message => "Subject too long - max 50 characters"
	validates_length_of :question, :maximum => 5000, :message => "Question too long - max 500 characters"
end	
