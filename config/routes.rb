CraftWiki::Application.routes.draw do

  #match '/posts/mars-rover-kata' => redirect('/katas/mars-rover-kata')
  #match '/posts/unbeatable-tic-dash-tac-dash-toe' => redirect('/katas/unbeatable-tic-dash-tac-dash-toe')
  #match '/posts/across-the-board-kata' => redirect('/katas/across-the-board-kata')
  #match '/posts/potter-kata' => redirect('/katas/potter-kata')
  #match '/posts/prime-factors-kata' => redirect('/katas/prime-factors-kata')
  #match '/posts/tennis-game-kata' => redirect('/katas/tennis-game-kata')
  #match '/posts/recycled-numbers' => redirect('/katas/recycled-numbers')
  #match '/posts/weighing-with-stones-kata' => redirect('/katas/weighing-with-stones-kata')
  #match '/posts/coin-change-kata' => redirect('/katas/coin-change-kata')
  #match '/posts/string-calculator' => redirect('/katas/string-calculator')
  #match '/posts/mars-rover-kata' => redirect('/katas/mars-rover-kata')
  #match '/posts/gilded-rose-kata' => redirect('/katas/gilded-rose-kata')


  devise_for :users do
    match 'users/sign_in', :to => "devise/sessions#new"
    match 'users/:id', :to => 'users#show'
    match 'logout', :to => 'devise/sessions#destroy', :as => :logout
  end

  resources :users do
    resources :plans do
      resources :activities
    end
  end

  resources :search, :only => [:index]
  resources :achievements
  resources :authentications
  resources :likes
  resources :tags
  resources :posts do
    resources :comments
  end
  resources :articles, :controller => "posts", :type => "Article" do
    resources :comments
  end

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
