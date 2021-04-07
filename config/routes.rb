Rails.application.routes.draw do
  get "static_pages/home", to: "static_pages#home", as: "home"
  get "static_pages/season_show/:season/:serie", to: "static_pages#season_show", as: "season_show"
  get "static_pages/episode_show/:episode_id", to: "static_pages#episode_show", as: "episode_show"
  get "static_pages/character_show/:character_name", to: "static_pages#character_show", as: "character_show", constraints: { character_name: /[^\/]+/ }
  post "static_pages", to: "static_pages#character_search", as: "character_search"
  get "static_pages/search_results/:character_input", to: "static_pages#search_results", as: "search_results"

  root to: "static_pages#home"
end
