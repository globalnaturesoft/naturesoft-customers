Naturesoft::Customers::Engine.routes.draw do
  namespace :backend, module: "backend" do
    resources :customers
  end
end