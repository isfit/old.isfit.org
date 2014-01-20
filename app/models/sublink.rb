class Sublink < ActiveRecord::Base
  self.primary_key = 'id'
  lang_attr :title
  belongs_to :tab
  belongs_to :page
end
