Rails.application.routes.draw do


  get 'members/:id/block_user' => 'members#block_user', as: :block_user

  get 'payments/sent'
  put 'payments/:id/withdraw' => 'payments#withdraw', as: :withdraw
  put 'payments/cancel'

  mount_devise_token_auth_for 'User', at: 'auth'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  get 'me' => 'users#me'
  get 'stripe/customer/:customer_id' => 'merchants#customer', as: :stripe_customer
  post 'stripe/charge' => 'merchants#charge', as: :charge
  post 'stripe/customer/sources' => 'merchants#customer_sources', as: :customer_sources
  post 'stripe/customer/default_source' => 'merchants#customer_default_source', as: :customer_default_source
  post 'stripe/charge_card' => 'merchants#charge_card', as: :charge_card

  post 'stripe/webhook' => 'merchants#webhook', as: :stripe_webhook
  get 'stripe/webhook' => 'merchants#webhook', as: :get_stripe_webhook

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resources :contacts
  resources :invitations
  resources :payments
  resources :members

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
