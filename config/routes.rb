Rails.application.routes.draw do

  devise_for :users, :path_prefix => 'd', controllers: {
        registrations: 'users/registrations'
      }
  resources 'histories'
  resources 'users', except: [:new, :create, :show]
  get 'history/list', to: 'histories#list'
  root "histories#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
