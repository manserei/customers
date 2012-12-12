Customers::Application.routes.draw do
  resources :customers do
    resources :projects
  end
end
