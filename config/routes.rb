Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do 
    # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
      
    root to: 'home#index'

    match '/discover', to: 'discover#index', via: :get
    match '/story', to: 'story#index', via: :get

    get 'promo_code', to: 'cart#promo_code'
    post 'promo_code', to: 'cart#check_promo_code'
    delete 'promo_code', to: 'cart#destroy_promo_code'

    get 'travel/find_city_ids/:id' => 'travel#find_city_ids'
    get 'travel/sort-trips-country/:id' => 'travel#sort_trips_country'
    get 'travel/sort-trips-date/:id' => 'travel#sort_trips_date'
    get 'travel/sort-trips-theme/:id' => 'travel#sort_trips_theme'

    resources :trips, :path => 'travel'
    resources :travellers
    resources :places, :path => 'share'
    resources :orders
    resources :carts
  end
end
