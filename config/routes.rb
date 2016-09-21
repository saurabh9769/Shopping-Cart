Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'
  devise_for :admins
  devise_for :users
  resources :products
  get 'home/add_to_cart' => 'home#add_to_cart'
  get 'home/remove_from_cart' => 'home#remove_from_cart'
  get 'home/show_cart' => 'home#show_cart'
  post 'home/show_cart' => 'home#show_cart'
  get 'home/redeem_coupon' => 'home#redeem_coupon'
  get 'home/product_show_cart' => 'home#product_show_cart'
  get 'home/cart_quantity_up' => 'home#cart_quantity_up'
  get 'home/cart_quantity_down' => 'home#cart_quantity_down'

  mount RailsAdmin::Engine => '/admins', as: 'rails_admin'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
