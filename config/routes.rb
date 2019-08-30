Rails.application.routes.draw do
  devise_for :users#, controllers: { sessions: 'users/sessions' }
  get 'roles/new'
  get 'roles/create'
  get 'roles/edit'
  get 'roles/show'
  get 'welcome/index'

  resources :applicants

  # resources :sessions   
  
  resources :roles 
  resources :users do 
    member do
      post :role_save
      get  :role_assignment
    end
  end
  
  resources :borrows do
    member do
      post :examine_do
      get  :examine
      
      post :return_do
      get  :return

      post :return_list_do
      get  :return_list
    end
  end

  resources :articles do
    member do
      post :article_borrow_do
      get  :article_list
    end
    collection do
      post :article_excel
    end 
  end
  
  resources :catalogs do
    collection do
      get :catalogs_view
    end
  end
 
  resources :clients
  resources :lists
  
  root to: "articles#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
