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
    # binding.pry
    unless params[:diet].empty?
      diet = Diet.where( :diet_type => params[:diet] )[0]
      # If this is nil
        # Go to the api
      recipes = diet.recipes
    end
    @ingredients = [params[:ingredient1],params[:ingredient2],params[:ingredient3]].flatten.compact.delete_if(&:empty?)

    @title = @ingredients.flatten.compact.delete_if(&:empty?).join(',')
    # binding.pry
    if recipes.nil?
      search_results(@title)
    else
      search_results(@title, recipes)
    end
  end



# Search the results based on the arg title, which is either the recipe name or the list of ingredients
# This is where we display the results
#sets the url and the HTTParty generates the url . results are fed in to the recipelist and the search results page is displayed
# due to the problem in heroku had to encode and parse the url 

  def search_results( title = @title, recipes = Recipe.all )

    # binding.pry

    # binding.pry
    if title 
      setup_keys()
     
      # if present in db , then 
     recipe_result = recipes.find_by(:title => title)
      if recipe_result.nil?
  
        @recipes = fetch_from_api( title )
      else

        @recipes = recipes.where("title = ?", title)
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
  
    def fetch_from_api (title)
      url = "https://api.edamam.com/search?q=#{ title }&app_id=#{ @app_id }&app_key=#{ @app_key }"
      encoded_url = URI.encode(url.strip)
      uri = URI.parse(encoded_url)
      @recipe_data = HTTParty.get uri if uri
      # @recipe_list = []
      @recipes = []
      @recipe_data['hits'].each do |recipe|
        # @recipe_list << recipe['recipe']
        @recipes << add_to_database(recipe)
        end
      @recipes
    end

    # adding contents to the database tables recipe and to the diet 
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
        @diet = Diet.find_by(:diet_type => type)
        if @diet.nil?
          @diet = Diet.create(:diet_type => type)
        end 
        recipe_db.diets << @diet # guarantted to be in the DB
      end 

      recipe_db
    end

    # for future uses , currently not used 
    def recipe_params
      params.require(:recipe).permit(:title, :image_url, :source_url , :edamaam_uri , :summary , :total_time , :prep_time , :cooking_time, :no_of_serves , :rating ,  :difficulty_level , :ingredient_lines)
    end

    def diet_params
      params.require(:diet).permit(:diet_type)
    end

end
