Rails.application.routes.draw do
  get 'designs/new'
  get 'designs/show'

  get 'images/mockups/*text.:format', to: 'images#mockup', as: :mockup_image, defaults: { design: 'supreme', format: 'jpg' }
  get 'images/printfiles/:variant_id/:design/*text.:format', to: 'images#product_variant', as: :product_variant_image, defaults: { design: 'supreme', format: 'png' }
  get 'images/:design(/x:size)/*text.:format', to: 'images#show', as: :generated_image, defaults: { design: 'supreme', format: 'png' }

  get 'cart', to: 'cart#show'
  post 'cart/add', to: 'cart#add', as: :add_to_cart

  get 'checkout', to: 'orders#new', as: :checkout

  post 'orders', to: 'orders#create', as: :create_order
  get 'orders/:id', to: 'orders#show', as: :order
end
