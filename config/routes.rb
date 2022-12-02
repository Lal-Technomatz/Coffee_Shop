Rails.application.routes.draw do
  resources :discounts
  resources :tax_categories
  resources :items
  resources :orders
  resources :order_items
  root "items#index"
end
