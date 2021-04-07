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
    @serie_id = serie
    @season = season
  end

  def episode_show
    episode_id = params[:episode_id]
    response = RestClient.get(@@base_url + "episodes/#{episode_id}")
    episodes = JSON.parse(response.to_str)
    @results = episodes[0]
    if episodes[0]["series"] == "Breaking Bad"
      @image_path = "/fotos/Breaking_Bad_logo.png"
    else
      @image_path = "/fotos/BCS_logo.png"
    end
    # Si está muy lento borrar desde acá
    # @characters = {}
    # @results["characters"].each do |char|
    #   response = RestClient.get(@@base_url + "characters?name=#{char}")
    #   characters = JSON.parse(response.to_str)
    #   result = characters[0]
    #   @characters[char] = result["img"]
    # end
  end

  def character_show
    character_name = params[:character_name]
    response = RestClient.get(@@base_url + "characters?name=#{character_name}")
    characters = JSON.parse(response.to_str)
    @results = characters[0]
    response = RestClient.get(@@base_url + "quote?author=#{character_name}")
    @quotes = JSON.parse(response.to_str)
  end

  def character_search
    character_input = params[:character_input]
    redirect_to search_results_path(character_input)
  end

  def search_results
    @character_input = params[:character_input]
    respuestas = RestClient.get(@@base_url + "characters?name=#{@character_input}")
    respuestas = JSON.parse(respuestas.to_str)
    response = []
    response += respuestas
    pag = 1
    until respuestas.empty?
      respuestas = RestClient.get(@@base_url + "characters?name=#{@character_input}&limit=10&offset=#{10 * pag}")
      respuestas = JSON.parse(respuestas.to_str)
      response += respuestas
      pag += 1
    end
    @results = response
  end
end
