GenContractorMatching::Application.routes.draw do
  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  
  
  devise_for :users
  devise_for :contractors

  namespace :admin do
    root "base#index"
    resources :users
    
  end

  resources :contractors do
    collection do 
      get :edit_profile
      post :update_profile
      get :my_projects
      get :accept_project
    end
  end

  resources :projects do
  	collection do
  	  get :my_projects
      get :near_by_contractors
      get :assign_contractor
  	end
  end

end
