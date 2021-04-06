class StaticPagesController < ApplicationController
  @@base_url = 'https://tarea-1-breaking-bad.herokuapp.com/api/'
  def home
    response = RestClient.get(@@base_url + 'episodes?series=Breaking+Bad')
    bb_episodes = JSON.parse(response.to_str)
    response = RestClient.get(@@base_url + 'episodes?series=Better+Call+Saul')
    bcs_episodes = JSON.parse(response.to_str)
    seasons = {bb: [], bcs: []}
    bb_episodes.each do |epi|
      if !seasons[:bb].include? epi["season"].to_i
        seasons[:bb] << epi["season"].to_i
      end
    end
    bcs_episodes.each do |epi|
      if !seasons[:bcs].include? epi["season"].to_i
        seasons[:bcs] << epi["season"].to_i
      end
    end
    @results = seasons
  end

  def season_show
    season = params[:season]
    serie = params[:serie]
    if serie == "bb"
      serie_name = "Breaking+Bad"
    elsif serie == "bcs"
      serie_name = "Better+Call+Saul"
    end
    response = RestClient.get(@@base_url + "episodes?series=#{serie_name}")
    episodes = JSON.parse(response.to_str)
    season_episodes = []
    episodes.each do |epi|
      if epi["season"] == season
        season_episodes << epi
      end
    end
    @results = season_episodes
  end
end
