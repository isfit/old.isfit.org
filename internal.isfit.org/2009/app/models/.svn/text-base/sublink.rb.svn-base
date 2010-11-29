class Sublink < ActiveRecord::Base
  validates_presence_of :title_en, :message => "Needs english title"
  validates_presence_of :title_no, :message => "Needs norwegian title"
  
  # def validate
  #     if ((url.blank?) and (external_url.blank?))
  #       errors.add_on_empty([:url],"You need either an internal or external URL")
  #       # errors.add("You need either an internal or external URL")
  #     end
  # end
  
  
  def delete
    self.deleted = 1
    self.save
    
    #Funksjon for aa sikre at linkene har etterfolgende nummer i order
    i=0
    links = SublinkController.get_sublinks(self.tab_id)
    links.each do |l|
      s_link = Sublink.find(l.id)
      s_link.order =i
      s_link.save
      i=i+1
    end
  end
  
  
  
end
