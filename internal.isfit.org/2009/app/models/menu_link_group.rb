class MenuLinkGroup < ActiveRecord::Base

	belongs_to :menu_tab
	has_many :menu_links

end
