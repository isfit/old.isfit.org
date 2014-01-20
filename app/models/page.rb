class Page < ActiveRecord::Base
  self.primary_key = 'id'
  lang_attr :title, :ingress, :body
end
