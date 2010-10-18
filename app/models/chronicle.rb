class Chronicle < ActiveRecord::Base
  lang_attr :title, :ingress, :body

  # Finner og returnerer den kronikken med høyest vekt
  def self.find_most_recent(nbr=1)
    Chronicle.find(:all,:limit => nbr, :order => "weight DESC") 
  end

  def self.find_all()
    Chronicle.find(:all, :order=> "weight DESC")
  end
end
