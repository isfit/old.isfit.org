class FrontendArticle < ActiveRecord::Base
  def self.get_all_not_deleted
    FrontendArticle.find(:all, :conditions => {:deleted => "0"})
  end


 def validate
    tmp = 0
    if published 
     if (!(title_no.blank?) or !(ingress_no.blank?) or !(body_no.blank?))
       errors.add_on_empty([:title_no], "Norwegian article needs title")
       errors.add_on_empty([:ingress_no], "Norwegian article needs ingress")
       errors.add_on_empty([:body_no], "Norwegian article needs body")

       tmp = 1
     end
     if (!(title_en.blank?) or !(ingress_en.blank?) or !(body_en.blank?))
       errors.add_on_empty([:title_en], "English article needs title")
       errors.add_on_empty([:ingress_en], "English article needs ingress")
       errors.add_on_empty([:body_en], "English article needs body")

       tmp = 1
     end
     if tmp == 0
       errors.add_on_empty([:body_no],"You need to write an article in either norwegian or english")
     end
    end
 end
end
