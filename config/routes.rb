Rails.application.routes.draw do
  get "static_pages/home", to: "static_pages#home", as: "home"
  get "static_pages/season_show/:season/:serie", to: "static_pages#season_show", as: "season_show" 

  root to: "static_pages#home"
end
