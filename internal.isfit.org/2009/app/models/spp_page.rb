class SppPage < ActiveRecord::Base
  
  validates_presence_of :title, :message => "Title is missing"
  validates_presence_of :ingress, :message => "Ingress is missing"
  validates_presence_of :body, :message => "Page is missing"
end