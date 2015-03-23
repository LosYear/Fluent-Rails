class NodeRouter
  def call env
    slug = env['action_dispatch.request.path_parameters'][:path]
    env['action_dispatch.request.path_parameters'][:id] = slug

    type = Node.find_by(slug: slug).type

    controller = type[0..type.index('#')-1]
    action = type[type.index('#')+1..-1]

    controller_class= (controller + '_controller').camelize.constantize
    controller_class.action(action.to_sym).call(env)
  end
end

Fluent::Application.routes.draw do
  resources :socials

  mount Ckeditor::Engine => '/ckeditor'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get '*path(.:format)', to: NodeRouter.new,
      constraints: lambda { |request|
        format_pos = request.path.index('.') || 0
        Node.where(slug: request.path[1..format_pos-1]).count > 0
      }, format: {}

  root 'main#index'
  devise_for :users, :path_names => {:sign_in => "login", :sign_out => "logout"}, :path => "user"
  resources :users

  namespace :admin do
    match '/' => 'users#index', via: :all
    resources :users
    resources :socials
    resources :settings
    resources :roles
    resources :pages
    resources :news
    resources :blocks
    resources :blog, as: 'posts'
    resources :menus
    resources :menu_items do
      collection do
        post 'change_order'
      end
    end
  end

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
