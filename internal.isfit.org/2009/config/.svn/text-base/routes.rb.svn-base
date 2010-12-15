ActionController::Routing::Routes.draw do |map|
  map.root :tab => 'organization', :controller => 'article', :action => 'index'
  map.connect ':tab/:controller/:action/:id',
    :id => /.*/
end
