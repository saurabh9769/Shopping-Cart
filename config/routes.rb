Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  match 'home/index' => 'home#index', via: [:get, :post]

  root 'home#index'
  devise_for :admins
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  resources :products
  get 'home/add_to_cart' => 'home#add_to_cart'
  get 'home/remove_from_cart' => 'home#remove_from_cart'
  get 'home/show_cart' => 'home#show_cart'
  post 'home/show_cart' => 'home#show_cart'
  get 'home/redeem_coupon' => 'home#redeem_coupon'
  post 'home/redeem_coupon' => 'home#redeem_coupon'
  get 'home/product_show_cart' => 'home#product_show_cart'
  get 'home/coupon_used' => 'home#coupon_used'
  get 'home/cart_quantity_up' => 'home#cart_quantity_up'
  get 'home/cart_quantity_down' => 'home#cart_quantity_down'
  match 'home/contact_us' => 'home#contact_us', via: [:get, :post]
  resources :orders do
    match 'orders/checkout' => 'orders#checkout', on: :collection, via: [:get, :post]
    match 'orders/redeem_coupon' => 'orders#redeem_coupon', on: :collection, via: [:get, :post]
    match 'orders/remove_from_cart' => 'orders#remove_from_cart', on: :collection, via: [:get, :post]
    match 'orders/coupon_used' => 'orders#coupon_used', on: :collection, via: [:get, :post]
    match 'orders/quantity_up' => 'orders#quantity_up', on: :collection, via: [:get, :post]
    match 'orders/quantity_down' => 'orders#quantity_down', on: :collection, via: [:get, :post]
    match 'orders/proceed_to_payment' => 'orders#proceed_to_payment', on: :collection, via: [:get, :post]
    match 'orders/make_payment' => 'orders#make_payment', on: :collection, via: [:get, :post]
    match 'orders/my_orders' => 'orders#my_orders', on: :collection, via: [:get, :post]
    match 'orders/track_package' => 'orders#track_package', on: :collection, via: [:get, :post]
  end
  resources :user_addresses
  resources :charges
  match 'user_wish_list/show_wish_list' => 'user_wish_list#show_wish_list', via: [:get, :post]
  delete 'user_wish_list/remove_from_wish_list' => 'user_wish_list#remove_from_wish_list'
  get 'user_wish_list/add_to_cart' => 'user_wish_list#add_to_cart'
  # errdo.root_path

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
