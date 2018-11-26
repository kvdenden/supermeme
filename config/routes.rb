Rails.application.routes.draw do
  get 'designs/new'
  get 'designs/show'

  get 'images/mockups/*text.:format', to: 'images#mockup', as: :mockup_image, defaults: { format: 'jpg' }
  get 'images/:generator(/x:size.)/*text.:format', to: 'images#show', as: :generated_image, defaults: { generator: 'supreme', format: 'png' }
end
