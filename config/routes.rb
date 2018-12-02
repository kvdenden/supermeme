Rails.application.routes.draw do
  get 'designs/new'
  get 'designs/show'

  get 'images/mockup/:design/*text.:format', to: 'images#mockup', as: :mockup_image, defaults: { design: 'supreme', format: 'jpg' }
  get 'images/:variant_id/:design/*text.:format', to: 'images#product_variant', as: :product_variant_image, defaults: { design: 'supreme', format: 'png' }
  get 'images/:design(/x:size.)/*text.:format', to: 'images#show', as: :generated_image, defaults: { design: 'supreme', format: 'png' }
end
