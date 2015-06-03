# == Route Map
#
#                     Prefix Verb URI Pattern                           Controller#Action
#                       root GET  /                                     recipes#home
#             recipes_search GET  /recipes/search(.:format)             recipes#search_recipes
# recipes_search_ingredients GET  /recipes/search_ingredients(.:format) recipes#multiple_ingredients_search
#             search_results GET  /recipes/search_results(.:format)     recipes#search_results
#

Rails.application.routes.draw do

root :to => 'recipes#home'
get '/recipes/search' => 'recipes#search_recipes'
get '/recipes/search_ingredients' => 'recipes#multiple_ingredients_search'
get '/recipes/search_results' => 'recipes#search_results', :as => "search_results"

end
