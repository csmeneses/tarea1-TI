class StaticPagesController < ApplicationController
  def home
    base_url = 'https://tarea-1-breaking-bad.herokuapp.com/api/'
    response = RestClient.get(base_url + 'characters/1')
    @results = JSON.parse(response.to_str)
    # name = results['forms'][0]['name']
  end
end
