Rails.application.routes.draw do
  resources :profiles
  resources :professional_professions
  resources :service_professional_feedbacks
  resources :professionals
  resources :professional_services
  resources :services
  resources :categories
  get 'message/index'

  devise_for :users, controllers: { sessions: "users/sessions",confirmations: "users/confirmations", registrations: "users/registrations", passwords: "users/passwords"}
  get 'cep/search/:id' =>  'cep#search', as: 'cep_search'
  get 'professionals/cep/:id' =>  'professionals#search', as: 'professionals_search'
  get 'professionals/service/update_services' =>  'professionals#update_services', as: 'update_services'
  get 'professionals/service/update_city_list' =>  'professionals#update_city_list', as: 'update_city_list'

  get 'professional/professional_services/new' =>  'professionals#new_professional_services', as: 'professionals_new_professional_services'
  post 'professional/professional_services/create' =>  'professionals#create_professional_services', as: 'professionals_create_professional_services'
  get 'professional/professional_services/:service_id/edit' =>  'professionals#edit_professional_services', as: 'professionals_edit_professional_services'
  resources :professions

  devise_scope :user do
    get "/users/cancel" => "users/registrations"
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get 'servicesByCategory/retrieveByCategory' => "services#retrieveByCategory", :as => 'remote_select' 

  get "list_professional_service" => "professional_services#index"

  get "new_profile" => "profiles#new"
  
  get "view_profile" => "profiles#index"
  
  # Example of regular route:
  #

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
