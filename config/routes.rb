Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
  end

  namespace :admins_backoffice do
    get 'welcome/index'
    resources :admins # cria todas as rotas padrão, only: filtra as necessárias, except: faz o contrário
    resources :subjects
    resources :questions
    #get 'admins/index', forma manual de criar as rotas
    #get 'admins/edit/:id', to: 'admins#edit'
  end
  
  namespace :users_backoffice do
    get 'welcome/index'
  end

  devise_for :admins
  devise_for :users

  get 'inicio', to: 'site/welcome#index'
  
  root to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end