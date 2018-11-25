Rails.application.routes.draw do
  get 'designs/new'
  get 'designs/show'

  get 'images/:generator(/x:size.)*text.:format', to: 'images#show', as: :generated_image, defaults: { generator: 'supreme', format: "png" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
