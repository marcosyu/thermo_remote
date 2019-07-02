Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      post 'reading', to: 'reading#create'
      get 'reading', to: 'reading#show'
      get 'stats', to: 'state#index'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
