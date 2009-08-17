ActionController::Routing::Routes.draw do |map|
  map.resources :memberships

  map.login "login", :controller => "user_sessions", :action => "new", :subdomain => false
  map.logout "logout", :controller => "user_sessions", :action => "destroy", :subdomain => false
  map.memberlogin "memberlogin", :controller => "member_sessions", :action => "new", :subdomain => false
  map.memberlogout "memberlogout", :controller => "member_sessions", :action => "destroy", :subdomain => false
  
  map.resources :user_sessions
  map.resources :users
  map.resources :members, :has_many=>:responses
  map.resources :member_sessions
  map.resources :responses
  map.resources :posts, :has_many=>:comments
  
  map.connect 'users/:id', :controller => 'users', :action => 'show'
  map.connect 'users/:id/edit', :controller => 'users', :action => 'edit'
  map.connect 'members/:id/posts', :controller => 'members', :action => 'posts'
  map.connect 'responses/new/:id', :controller => 'responses', :action => 'new'
  map.connect 'posts/new/:type/:member_id', :controller => 'posts', :action => 'new'
  map.connect 'posts/vote/:id/:vote', :controller => 'posts', :action => 'vote'
  map.connect 'posts/rank', :controller => 'posts', :action => 'rank'
  map.connect 'posts/rank/:type/:weeks', :controller => 'posts', :action => 'rank'
  map.connect 'categories', :controller => 'categories', :action => 'index'
  map.connect 'categories/:id', :controller => 'categories', :action => 'show'
  map.connect 'types/:id', :controller => 'types', :action => 'show'
  map.connect 'admin', :controller => 'users', :action => 'admin'
  map.connect 'admin/users', :controller => 'users', :action => 'manage_users'
  map.connect 'admin/posts', :controller => 'posts', :action => 'manage_posts'
  map.connect 'admin/members', :controller => 'members', :action => 'manage_members'
  
  map.root :controller => 'posts'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
