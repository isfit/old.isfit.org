class Sublink < ActiveRecord::Base
  set_primary_key 'id'
  lang_attr :title
  belongs_to :tab
  belongs_to :page
end
