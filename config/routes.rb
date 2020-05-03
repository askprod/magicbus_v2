Rails.application.routes.draw do
  resources :trips
  resources :travellers
  resources :places
  resources :orders
  resources :carts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
