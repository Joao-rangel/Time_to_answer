Rails.application.routes.draw do
  namespace :site do
    get  'welcome/index'
    get  'search', to: 'search#questions'
    #/:subject_id avisa que este será enviado ao controler / as: altera o path_helper
    get  'subject/:subject_id/:subject_description', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'
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
    get 'profile', to: 'profile#edit'
  end

  devise_for :admins, skip: 'registrations'
  devise_for :users

  get 'inicio', to: 'site/welcome#index'
  
  root to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end