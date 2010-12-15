class Faq < ActiveRecord::Base

	validates_presence_of :title, :message => "Title is required"
	validates_presence_of :body, :message => "Description is required"

end