Rails.application.routes.draw do
  root 'resumes#index'
  resources :resumes do
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

  # post 'resumes/:resume_id/simplelists/:simplelist_id/simplelistitems/:id/increase_order' => 'simplelistitems#increase_order', as: 'sl_item_incr_order'

  # post 'resumes/:resume_id/simplelists/:simplelist_id/simplelistitems/:id/decrease_order' => 'simplelistitems#decrease_order', as: 'sl_item_decr_order'

  ##### NOT USED ANYMORE #####
  # post 'resumes/:resume_id/multiline_lists/:id/increase_order' => 'multiline_lists#increase_order', as: 'mll_incr_order'
  # post 'resumes/:resume_id/multiline_lists/:id/decrease_order' => 'multiline_lists#decrease_order', as: 'mll_decr_order'

  # post 'resumes/:resume_id/simplelists/:id/increase_order' => 'simplelists#increase_order', as: 'simplelist_incr_order'
  # post 'resumes/:resume_id/simplelists/:id/decrease_order' => 'simplelists#decrease_order', as: 'simplelist_decr_order'

  # post 'resumes/:resume_id/textsections/:id/increase_order' => 'textsections#increase_order', as: 'textsection_incr_order'
  # post 'resumes/:resume_id/textsections/:id/decrease_order' => 'textsections#decrease_order', as: 'textsection_decr_order'
end
