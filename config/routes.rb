Getrepresented::Application.routes.draw do
  resources :memberships
  match 'login' => 'user_sessions#new', :as => :login, :subdomain => false
  match 'logout' => 'user_sessions#destroy', :as => :logout, :subdomain => false
  match 'memberlogin' => 'member_sessions#new', :as => :memberlogin, :subdomain => false
  match 'memberlogout' => 'member_sessions#destroy', :as => :memberlogout, :subdomain => false
  resources :user_sessions
  resources :users
  resources :members
  resources :member_sessions
  resources :responses
  resources :posts
  match 'users/:id' => 'users#show'
  match 'users/:id/edit' => 'users#edit'
  match 'members/:id/posts' => 'members#posts'
  match 'responses/new/:id' => 'responses#new'
  match 'posts/new/:type/:member_id' => 'posts#new'
  match 'posts/vote/:id/:vote' => 'posts#vote'
  match 'posts/rank' => 'posts#rank'
  match 'posts/rank/:type/:weeks' => 'posts#rank'
  match 'categories' => 'categories#index'
  match 'categories/:id' => 'categories#show'
  match 'types/:id' => 'types#show'
  match 'admin' => 'users#admin'
  match 'admin/users' => 'users#manage_users'
  match 'admin/posts' => 'posts#manage_posts'
  match 'admin/members' => 'members#manage_members'
  match '/' => 'posts#index'
end
