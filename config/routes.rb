Rails.application.routes.draw do

  root 'home#index'
  
  get 'badge(/:spec).:format', \
      to: 'badge#generate', spec: /pylint(-(10|\d)\.\d\d)?/, format: /svg/
      
  get 'github/:organization/:repository.:format',
      to: 'badge#github', format: /svg/
  get 'github/:organization/:repository/:module.:format',
      to: 'badge#github', format: /svg/
  get 'github/:organization/:repository/:branch/:module.:format',
      to: 'badge#github', format: /svg/
end
