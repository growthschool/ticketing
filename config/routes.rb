Rails.application.routes.draw do
  devise_for :users
  namespace :admin do

    root "base#index"

    resources :events do 
      resources :ticket_types
      resources :registrations do 
        collection do 
          get :not_placed_not_expired
          get :not_placed_expired
          get :already_canceled
          get :still_can_pay
          get :cant_pay
          get :all
        end
      end

      member do 
        post :publish
        post :draft
        get :info

      end

      resources :tickets
    end

    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  namespace :account do
    resources :orders
  end

  resources :events do
    resources :registrations do 
      member do
        get :payinfo
        get :expired
        get :canceled
        post :redo
      end

    end
  end

  resources :carts do
    post "checkout", on: :collection
    delete "clean",  on: :collection
  end

  resources :orders do
    member do
      get :pay_with_credit_card

      post 'pay2go_cc_notify'
      post 'pay2go_atm_code'
      post 'pay2go_atm_complete'
      post 'complete'
    end


  end


  get "/pages/:action" , :controller => "pages"

  root "events#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
