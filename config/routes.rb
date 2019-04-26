Rails.application.routes.draw do
  api_version(:module => "V1", :path => {:value => "v1"}, :default => false) do
    resources :posts, only: [:index, :show]
    end  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'posts#index'
  get 'news/:id', to: 'posts#show', as: 'news'
  get '/test' , to: 'posts#tests'
  get '/god_post', to: 'posts#god_post' , as: 'god_post'
  get '/evn', to: 'tools#new', as: 'env'

end
