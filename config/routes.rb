Rails.application.routes.draw do
  #resources :friends

  root 'home#index'
  get 'home/about'
  resources :friends do
    resources :blogs
  end

  get 'error', to: 'blogs#error', as: 'error'
  get  'friend/:friend_id/blog/:id/publish', to: 'blogs#publish', as: 'blog_publish'
  get 'friend/new', to: 'friends#new', as: 'newforms_friends'


  #get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
