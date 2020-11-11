Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount StripeEvent::Engine, at: '/stripe/webhook'

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do 

    devise_for :users, controllers: { 
      sessions: 'users/sessions', 
      registrations: 'users/registrations', 
      confirmations: 'users/confirmations', 
      passwords: 'users/passwords',
    }

    root to: 'home#index'

    match '/discover', to: 'discover#index', via: :get
    match '/story', to: 'story#index', via: :get

    resource :user, only: [:edit] do
      collection do
        patch 'update_password'
      end
    end
    
    resources :trips, :path => 'travel', only: [:index, :show] do
      post 'add_to_cart', on: :collection
      post 'remove_from_cart', on: :collection
    end

    resources :orders, only: [:index, :show, :create, :edit, :update, :destroy] do
      get 'new_payment', to: 'orders#new_payment'
      post 'new_payment', to: 'orders#create_payment'
      get 'success-payment', to: 'orders#success_payment'
      get 'promo_code', to: 'orders#promo_code'
      post 'promo_code', to: 'orders#check_promo_code'
      delete 'promo_code', to: 'orders#destroy_promo_code'
      post 'update-rgpd-validation', to: 'orders#update_rgpd_validation'
    end

    resources :carts, only: [:show] do
      post "change-traveller-quantity", to: "carts#change_traveller_quantity"
    end

    resources :trip_quotations, only: [:new, :create]
    resources :travellers, only: [:new, :create, :edit, :update, :destroy]
    resources :places, :path => 'share', only: [:index, :new, :create, :edit, :update, :destroy]

    get '/newsletter' => 'newsletter#new'
    post '/newsletter' => 'newsletter#create'

    get '/faq' => 'helps#index'
    get 'travel/sort-trips-country/:id' => 'trips#sort_trips_country'
    get 'travel/sort-trips-date/:id' => 'trips#sort_trips_date'
    get 'travel/sort-trips-theme/:id' => 'trips#sort_trips_theme'

    post 'newsletter/add-subscribtion' => 'newsletter#user_add_subscribtion'
    post 'newsletter/delete-subscribtion' => 'newsletter#user_delete_subscribtion'

  end
end
