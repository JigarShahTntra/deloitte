Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: 'organization' do
    resources :organizations do
      resources :users
    end
  end
  # resources :organizations
  root to: "home#index"
end
