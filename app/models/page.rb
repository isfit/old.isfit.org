class Page < ActiveRecord::Base
  set_primary_key 'id'
  lang_attr :title, :ingress, :body
end
