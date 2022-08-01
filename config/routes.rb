Rails.application.routes.draw do
  root 'home#index'

  scope :users do
    # scope :users do
    get 'signin', to: 'session#new'
    post 'signin', to: 'session#create'
    delete 'signout', to: 'session#destroy'

    get 'signup', to: 'users#new'
    post 'signup', to: 'users#create'
    get 'cancel', to: 'users#cancel'
    delete 'cancel', to: 'users#destroy'
    # resource :session, only: %i[new create destroy], shallow: true
  end

  # resources :users, only: %i[new create destroy] do
  # member do
  #   get 'signin', to: 'session#new'
  #   post 'signin', to: 'session#create'
  #   delete 'signout', to: 'session#destroy'
  # end
  # end
end
