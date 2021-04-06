Rails.application.routes.draw do
  get "static_pages/home", to: "static_pages#home", as: "home"

  root :to => "static_pages#home"
end
