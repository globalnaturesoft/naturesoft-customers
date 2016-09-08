Naturesoft::Customers::Engine.routes.draw do
  namespace :admin, module: "admin" do
    resources :customers
  end
end