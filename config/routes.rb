Rails.application.routes.draw do
  root 'resumes#index'
  resources :resumes do
    resources :educations
    resources :works
    resources :simplelists do
      resources :simplelistitems
    end
    resources :multiline_lists do
      resources :multiline_list_items
    end
    resources :textsections
  end

  post 'resumes/:resume_id/multiline_lists/:multiline_list_id/multiline_list_items/:id/increase_order' => 'multiline_list_items#increase_order', as: 'mll_item_incr_order'

  post 'resumes/:resume_id/multiline_lists/:multiline_list_id/multiline_list_items/:id/decrease_order' => 'multiline_list_items#decrease_order', as: 'mll_item_decr_order'

  post 'resumes/:resume_id/multiline_lists/:id/increase_order' => 'multiline_lists#increase_order', as: 'mll_incr_order'
  post 'resumes/:resume_id/multiline_lists/:id/decrease_order' => 'multiline_lists#decrease_order', as: 'mll_decr_order'


  post 'resumes/:resume_id/simplelists/:id/increase_order' => 'simplelists#increase_order', as: 'simplelist_incr_order'
  post 'resumes/:resume_id/simplelists/:id/decrease_order' => 'simplelists#decrease_order', as: 'simplelist_decr_order'

  post 'resumes/:resume_id/textsections/:id/increase_order' => 'textsections#increase_order', as: 'textsection_incr_order'
  post 'resumes/:resume_id/textsections/:id/decrease_order' => 'textsections#decrease_order', as: 'textsection_decr_order'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

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
