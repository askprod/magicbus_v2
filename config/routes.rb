Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do 
    # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
      
    root to: 'home#index'

    match '/discover', to: 'discover#index', via: :get
    match '/story', to: 'story#index', via: :get

    resources :trips, :path => 'travel', only: [:index] do
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
    end

    resources :carts, only: [:show] do
      post "change-traveller-quantity", to: "carts#change_traveller_quantity"
    end

    resources :travellers, only: [:new, :create, :edit, :update, :destroy]
    resources :places, :path => 'share', only: [:index, :new, :create, :edit, :update, :destroy]
  end

  get 'travel/sort-trips-country/:id' => 'trips#sort_trips_country'
  get 'travel/sort-trips-date/:id' => 'trips#sort_trips_date'
  get 'travel/sort-trips-theme/:id' => 'trips#sort_trips_theme'
end
