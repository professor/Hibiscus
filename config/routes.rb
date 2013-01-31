CraftWiki::Application.routes.draw do
  get "categories/index"

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

  devise_for :users do
    match 'users/sign_in', :to => "devise/sessions#new"
    #match 'users/:id', :to => 'users#show'
    match 'logout', :to => 'devise/sessions#destroy', :as => :logout
  end

  match '/users/restore/:id', to: 'users#restore', :as => :users_restore
  match '/users/obliterate/:id', to: 'users#obliterate', :as => :users_obliterate

  resources :users do
    resources :plans
  end

  resources :search, :only => [:index]
  resources :achievements
  resources :authentications
  resources :likes
  resources :tags
  resources :categories
  resources :flags

  resources :posts do
    member do
      post :upvote
      post :downvote
    end

    resources :comments do
      member do
        post :upvote
        post :downvote
      end
    end
  end

  resources :articles, :controller => "posts", :type => "Article" do
    resources :comments
  end

  resources :exercises, :controller => "posts", :type => "Kata" do
    resources :comments
  end

  match 'katas/random', :to => 'posts#random', :type => "Kata", :as => :random_kata

  resources :katas, :controller => "posts", :type => "Kata" do
    resources :reviews, :controller => "comments" do
      member do
        post :upvote
        post :downvote
      end
    end
  end

  match '/get_started', to: 'exercise_about_page#show'
  match '/auth/:provider/callback', :to => 'authentications#create'
  match '/auth/failure', :to => 'authentications#failure'
  match '/unsubscribe/:id', :to => 'users#unsubscribe'
  match '/popular', to: 'posts#index' , :popular => true

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
