class SppPage < ActiveRecord::Base
  
  validates_presence_of :title_en, :message => "Title is missing"
  validates_presence_of :ingress_en, :message => "Ingress is missing"
  validates_presence_of :body_en, :message => "Page is missing"
end
