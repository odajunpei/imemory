Rails.application.routes.draw do
  get 'search/search'
  #adminのルート
  devise_for :admin
  namespace :admin do
    resources :members, only: [:index,:show,:edit,:update]
    resources :products, only: [:index,:new,:create,:edit,:update,:show]
    resources :genres,only: [:index,:create,:edit,:update,:show]
    resources :orders, only: [:index, :show, :update]
    root to: 'orders#index'
    resources :order_products, only: [:update]
  end

  devise_for :members, :controllers  => {
    :registrations => 'members/registrations',
    :sessions => 'members/sessions'
  }

  scope module: :members do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    resource :members, only: [:show,:update]
    get 'members/myedit' => 'members#edit'
    patch 'members/myedit' => 'members#update'
    patch 'members/withdraw' => 'members#withdraw', as: :members_withdraw
    get 'members/leave' => 'members#leave'
    resources :products, only: [:show, :index]
    get 'search' => 'search'
    resources :cart_products, only: [:index, :create, :update, :destroy]
    delete 'cart_products' => 'cart_products#destroy_all', as: :destroy_all_members_cart_products
    post '/orders/info'  => 'orders#info'
    get  '/orders/thanks' => 'orders#thanks'
    resources :orders, only:[:new, :create, :show, :index]
    resources :destinations, only: [:index, :create, :edit, :update, :destroy]
  end

end


