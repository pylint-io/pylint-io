#
# Copyright (c) 2017 Muzo Labs
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# For a copy of the full license, see LICENSE file included in this
# distribution or http://www.gnu.org/license
#

Rails.application.routes.draw do

  root 'home#index'
  
  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get '/auth/failure', to: 'sessions#failure'
  
  resources :repositories, only: [:index, :show, :new, :create, :destroy]
  post '/ratings', to: 'ratings#create', as: :ratings
  
  get 'badge(/:spec).:format', \
      to: 'badge#generate', spec: /pylint(-(10|\d)\.\d\d)?/, format: /svg/

  scope "badge" do
    scope "github", to: "badge#github", format: /svg/, defaults: { format: :json } do
      get ":owner/:repository(.:format)"
      get ":owner/:repository/:module(.:format)"
      get ":owner/:repository/:branch/:module(.:format)"
    end
  end
end
