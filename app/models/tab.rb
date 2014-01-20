class Tab < ActiveRecord::Base
  self.primary_key = 'id'
  lang_attr :name
  has_many :sublinks, :conditions => {:deleted => false}, :order =>"`order`"
end
