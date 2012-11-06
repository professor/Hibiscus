CraftWiki::Application.routes.draw do
  get "categories/index"
  #get "categories/show"
  #get "categories/new"
  #get "categories/edit"
  #get "categories/create"
  #get "categories/update"
  #get "categories/destroy"

  devise_for :users do
    match 'users/sign_in', :to => "devise/sessions#new"
    #match 'users/:id', :to => 'users#show'
    match 'logout', :to => 'devise/sessions#destroy', :as => :logout
  end

  resources :users do
    resources :plans
  end

  resources :search, :only => [:index]
  resources :achievements
  resources :authentications
  resources :likes
  resources :tags

  match '/posts/mars-rover-kata' => redirect('/exercises/mars-rover-kata')
  match '/posts/unbeatable-tic-dash-tac-dash-toe' => redirect('/exercises/unbeatable-tic-dash-tac-dash-toe')
  match '/posts/across-the-board-kata' => redirect('/exercises/across-the-board-kata')
  match '/posts/potter-kata' => redirect('/exercises/potter-kata')
  match '/posts/prime-factors-kata' => redirect('/exercises/prime-factors-kata')
  match '/posts/tennis-game-kata' => redirect('/exercises/tennis-game-kata')
  match '/posts/recycled-numbers' => redirect('/exercises/recycled-numbers')
  match '/posts/weighing-with-stones-kata' => redirect('/exercises/weighing-with-stones-kata')
  match '/posts/coin-change-kata' => redirect('/exercises/coin-change-kata')
  match '/posts/string-calculator' => redirect('/exercises/string-calculator')
  match '/posts/mars-rover-kata' => redirect('/exercises/mars-rover-kata')
  match '/posts/gilded-rose-kata' => redirect('/exercises/gilded-rose-kata')

  resources :posts do
    resources :comments
  end
  resources :articles, :controller => "posts", :type => "Article" do
    resources :comments
  end
  resources :exercises, :controller => "posts", :type => "Kata" do
    resources :comments
  end
  resources :katas, :controller => "posts", :type => "Kata" do
    resources :reviews, :controller => "comments"
  end

  match '/get_started', to: 'start#show'
  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'

  root :to => 'posts#index'

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
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
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
  #       get 'recent', :on => :collection
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
