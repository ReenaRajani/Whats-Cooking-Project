# using the  API from edaman -> has provided the app id and app key api.edamam.com 
# app_id = "c5975da7"
# app_key = "5cc84166d69454f54ed43fb1bcb9b858

class RecipesController < ApplicationController
  
   before_filter :setup_keys
  
 

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
      setup_keys()
      url = "https://api.edamam.com/search?q=#{ title }&app_id=#{ @app_id }&app_key=#{ @app_key }"
      encoded_url = URI.encode(url.strip)
      uri = URI.parse(encoded_url)
      @recipe_data = HTTParty.get uri if uri
      @recipe_list = []
      @recipe_data['hits'].each do |recipe|
        @recipe_list << recipe['recipe']
        add_to_database(recipe)
      end
      render "recipes/search_results"
    end
  end
  
  def home
  end
  def index
  end

  private   
  # set the api.edamam.com's appkey and appid   
    def setup_keys
      @app_id = "c5975da7"
      @app_key = "5cc84166d69454f54ed43fb1bcb9b858"
    end
    def recipe_params
      params.require(:recipe).permit(:title, :image_url, :source_url , :edamaam_uri , :summary , :total_time , :prep_time , :cooking_time, :no_of_serves , :rating ,  :difficulty_level , :ingredient_lines)
    end

    def diet_params
      params.require(:diet).permit(:diet_type)
    end

    def add_to_database( recipe )
      recipe_db = Recipe.create(
        :title => recipe["recipe"]["label"],
        :image_url => recipe["recipe"]["image"],
        :source_url => recipe["recipe"]["url"],
        :edamaam_uri => recipe["recipe"]["uri"],
        :summary => recipe["recipe"]["summary"],
        :total_time => recipe["recipe"]["totalTime"],
        :prep_time => recipe["recipe"]["prepTime"],
        :cooking_time => recipe["recipe"]["cookingTime"],
        :no_of_serves => recipe["recipe"]["yield"],
        :rating => recipe["recipe"]["rating"],
        :difficulty_level => recipe["recipe"]["level"],
        :ingredient_lines => recipe["recipe"]["ingredientLines"].join(", ")
      )
      recipe["recipe"]["healthLabels"].each do |type|
      diet_db = Diet.create(
        :diet_type => type)
      end 

    end 

end
