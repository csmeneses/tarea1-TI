Rails.application.routes.draw do
  get "static_pages/home", to: "static_pages#home", as: "home"
  get "static_pages/season_show/:season/:serie", to: "static_pages#season_show", as: "season_show"
  get "static_pages/episode_show/:episode_id", to: "static_pages#episode_show", as: "episode_show"
  get "static_pages/character_show/:character_name", to: "static_pages#character_show", as: "character_show", constraints: { character_name: /[^\/]+/ }

  root to: "static_pages#home"
end
