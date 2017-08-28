Rails.application.routes.draw do

  root 'home#index'
  
  get 'badge(/:spec).:format', \
      to: 'badge#generate', spec: /pylint(-(10|\d)\.\d\d)?/, format: /svg/
      
  scope "github", to: "badge#github", format: /svg/, defaults: { format: :json } do
    get ":organization/:repository(.:format)"
    get ":organization/:repository/:module(.:format)"
    get ":organization/:repository/:branch/:module(.:format)"
  end
end
