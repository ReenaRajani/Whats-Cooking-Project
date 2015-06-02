# using the  API from edaman -> has provided the app id and app key api.edamam.com 
# app_id = "c5975da7"
# app_key = "5cc84166d69454f54ed43fb1bcb9b858

class RecipesController < ApplicationController
  
  # set the api.edamam.com's appkey and appid
  def initialize
    @app_id = "c5975da7"
    @app_key = "5cc84166d69454f54ed43fb1bcb9b858"
  end


  #  Search based on the recipe name 
  # gets the recipename as input and then calls the search_results function
  def search_recipes
    @title = params[:recipe_name]
    search_results(@title)
  end

# search based on the ingredient(s)
# title will be a csv of ingredients got as an input from the user 
  def multiple_ingredients_search
    @title = params[:ingredient1],params[:ingredient2],params[:ingredient3]
    search_results(@title)
    # binding.pry
  end


#Search the results based on the arg title, which is either the recipe name or the listof ingredients
# This is where we display the results
#sets the url and the HTTParty generates the url . results are fed in to the recipelist and the search results page is displayed
  def search_results( title = @title )
    if title 
      url = "https://api.edamam.com/search?q=#{ title }&app_id=#{ @app_id }&app_key=#{ @app_key }"
      encoded_url = URI.encode(url.strip)
      uri = URI.parse(encoded_url)
      @recipe_data = HTTParty.get uri if uri
      # @recipe_data = HTTParty.get url if url
      @recipe_list = []
      @recipe_data['hits'].each do |recipe|
        @recipe_list << recipe['recipe']
      end
      render "recipes/search_results"
    end
  end
  
  def home
  end
  def index
  end

end
