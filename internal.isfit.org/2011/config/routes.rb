ActionController::Routing::Routes.draw do |map|
  map.resources :wop_propositions, :path_prefix => ':tab'


  map.resources :isfit_media_links, :path_prefix => ':tab'

#  map.resources :pictures, :path_prefix => ':tab'
  map.resources :chronicles, :path_prefix => ':tab'
  map.resources :quiz_users, :path_prefix => ':tab'

  map.resources :quiz_choices, :path_prefix => ':tab'

  map.resources :quiz_questions, :path_prefix => ':tab'

  map.resources :quizzes, :path_prefix => ':tab'

  map.resources :spp_articles, :path_prefix => ':tab'

  map.resources :spp_pages, :path_prefix => ':tab'
  map.resources :photos, :path_prefix => ':tab', :member => {:crop => :get }

  map.resources :imf_contact_units, :path_prefix => ':tab', :has_many => :imf_contact_comments

  map.resources :economy_contact_logs, :path_prefix =>':tab'

  map.resources :economy_contact_units, :path_prefix =>':tab'

  map.resources :economy_contact_unit_types, :path_prefix =>':tab'

  map.resources :economy_contact_people, :path_prefix =>':tab'

  map.resources :frontend_article, :path_prefix =>':tab', :collection => {:new_pic => :get, :crop_main => :get }


  map.root :tab => 'organization', :controller => 'article', :action => 'index'
	# To route correctly for scaffolding, the example below should be used (you also have to update your views accordingly. See personal_contats in view) - Dag and Iver
	map.resources :personal_contacts, :path_prefix => ':tab', :collection => { :list => :get, :show_countries => :get }
        map.resources :positions, :path_prefix => ':tab'
	map.resources :sections, :has_many => :positions, :path_prefix => ':tab'
	#map.resources :positions, :path_prefix => ':tab
	map.connect ':tab/:controller/:action/:id',
	    :id => /.*/
end
