Rails.application.routes.draw do
    # namespace :users do
    #     get 'session/create'
    #     get 'session/destroy'

    #     # get 'registration/new'
    #     get 'signup', to: "registration#new"

    #     get 'registration/create'
    #     get 'registration/cancel'
    #     get 'registration/destroy'
    # end
    root 'home#index'

    scope :users,  module: :users do
        # scope :users do
        get 'signin', to: 'session#new'
        post 'signin', to: 'session#create'
        delete 'signout', to: 'session#destroy'

        get 'signup', to: 'registration#new'
        post 'signup', to: 'registration#create'
        get 'cancel', to: 'registration#cancel'

        get 'password', to: 'passwords#new', as: 'edit_user_password'
        patch 'password', to: 'passwords#update'
    end


    namespace(:api, model: :products, path_names: { new: 'neu', update: 'up', edit: 'down' }) do
        resource :passwords, only: [:new, :update, :edit] ,path: 'prova'
    end
    # resources :users, only: %i[new create destroy] do
    # member do
    #   get 'signin', to: 'session#new'
    #   post 'signin', to: 'session#create'
    #   delete 'signout', to: 'session#destroy'
    # end
    # end
end
