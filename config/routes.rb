Rails.application.routes.draw do
  match '(*any)', to: redirect(subdomain: ''), via: :all, constraints: { subdomain: 'www' }

  resource :design, only: [:new, :create, :show]

  get 'images/mockups/*text.:format', to: 'images#mockup', as: :mockup_image, defaults: { design: 'supreme', format: 'jpg' }
  get 'images/printfiles/:variant_id/:design/*text.:format', to: 'images#product_variant', as: :product_variant_image, defaults: { design: 'supreme', format: 'png' }
  get 'images/:design(/x:size)/*text.:format', to: 'images#show', as: :generated_image, defaults: { design: 'supreme', format: 'png' }

  get 'cart', to: 'cart#show'
  post 'cart/update', to: 'cart#update', as: :update_cart
  post 'cart/add', to: 'cart#add', as: :add_to_cart
  post 'cart/remove', to: 'cart#remove', as: :remove_from_cart

  get 'checkout', to: 'orders#new', as: :checkout
  get 'checkout/pay', to: 'orders#pay', as: :checkout_pay
  resources :orders, only: [:create]

  post 'charges', to: 'orders#charge'
  get 'countries/states', to: 'countries#states', as: :country_states
end
