Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  
  get 'badge(/:spec).:format', to: 'badge#generate', spec: /pylint(-(10|\d)\.\d\d)?/, format: /svg/

end
