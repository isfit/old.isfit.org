WwwIsfitOrg::Application.routes.draw do
  get "workshops/" => "workshops_public#index", as: "workshops_public_index"
  get "workshops/:id" => "workshops_public#show"

  get "online" => "isfit_onlines#show", as: "online"

  get "marketing/frontpage"

  get "instagram/map"
  get "instagram" => "instagram#map"

  get "ideas" => 'ideas#index'

  get "stats" => 'stats#index'

  get 'blog' => 'articles#blog', as: 'blog_root'
  get 'blogg', to: redirect('/blog')

  get 'latest_blogpost' => 'articles#latest_blogpost'
  get 'blog/latest' => 'articles#latest_blogpost', as: 'blog_latest'

  get 'blog/:id' => "articles#show", as: 'blog'

  get 'blogs/festival' => 'blogs#festival'
  get 'blogs/theme' => 'blogs#theme'
  # get 'blogs/:type/:lang' => 'blogs#index'
  # get 'blogs/' => 'blogs#index'

  get "ideas/:id" => 'ideas#show', as: "idea"
  get "ideas/:id/update" => 'ideas#update'

  post "ideas" => 'ideas#create'

  get "articles/all" => 'articles#all'
  resources :articles

  get "ambassadors" => "ambassadors#index"

  get 'oauth/start'
  get 'oauth/callback'

  get "ambassadors/new"

  post "ambassadors" => "ambassadors#create"

  get "ambassadors/thank_you"

  get "mailing_lists" => "mailing_lists#index"
  post "mailing_lists" => "mailing_lists#subscription"

  resources :tips_osses
  resources :isfit_media_links

  match 'project_supports/success' => "project_supports#success"
  resources :project_supports
  resources :sublinks
  resources :hosts do 
    collection do 
      get :done
    end
  end

  resources :alumni_reservations

  #get "events/:year/:month/:day" => "events#index", :as => "events"
  #get "events/:year/:month/:day" => "events#index", :as => "events_date"
  get 'events' => 'events#index'

  #get "events/search" => "events#search", :as => "search_events"

  #get "events/:category/:year/:month/:day" => "events#index", :as => "events_with_date_cat"

  #get "events/:category" => "events#index", :as => "events_cat"

  #get "event/:id" => "events#show", :as => "event"
  #get "events/:id" => "events#show"

  #get "event/:id/:event_date_id" => "events#show", :as => "event_date"

  get 'events/:id' => 'events#show'

  resources :events

  resources :pages, except: :index
  resources :press_accreditations
  resources :isfit_media_links
  resources :press_releases

  resources :workshops

  resources :participants

  resources :dialogue_participants

  get 'applicant/:id' => 'positions#update'

  resources :photos do
    member do
      get :crop
    end
  end

  #get "/signin", to: "sessions#new"
  #post "/signin", to: "sessions#create"

  #get "/forgotten_password", to: "sessions#forgotten_password"
  #post "/forgotten_password", to: "sessions#new_password"

  #get "logout", to: "sessions#destroy"

  #resources :applicant_users, except: [ :show, :destroy ]

  #get "/applicant_user", to: "applicant_users#show", as: :show_applicant_user

  #get "/positions/edit/:id", to: "positions#edit"

  resources :positions do
    collection do
      #get :apply
      #post :validate
      #post :save
    end
  end 

  match 'section/:id' => "positions#section", :tab => "admission", as: "positions_section"
  match 'group:id'    => "positions#group",   :tab => "admission", as: "positions_group"

  resources :donations do
    collection do
      get :donate
      get :thank_you
    end
  end

  resources :wop_propositions

  match 'opptak' => "positions#index", :tab => "admission"
  match 'apply/position' => "positions#index", :tab => "admission"
  match 'wop' => redirect("http://www.isfit.org/wop/wop_propositions/new")
  match "world-map" => "marketing#world_map"
  root :to => "marketing#frontpage"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  # match ':tab(/:controller(/:action(:id)))', :id => /.*/



end
