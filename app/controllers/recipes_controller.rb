# using the  API from edaman -> has provided the app id and app key api.edamam.com 
# app_id = "c5975da7"
# app_key = "5cc84166d69454f54ed43fb1bcb9b858

require 'pry'
class RecipesController < ApplicationController
  def index
    app_id = "c5975da7"
    app_key = "5cc84166d69454f54ed43fb1bcb9b858"
    @title =params[:title]
    if @title 
      url = "https://api.edamam.com/search?q=#{ @title }&app_id=#{ app_id }&app_key=#{ app_key }"
      @recipe_data = HTTParty.get url if url
      @recipe_list = []
      @recipe_data['hits'].each do |recipe|
        @recipe_list << recipe['recipe']
      end
    end
 
  end
  
  def home
    

  end

end