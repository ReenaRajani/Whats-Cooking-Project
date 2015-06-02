Rails.application.routes.draw do

root :to => 'recipes#home'
get '/recipes/search' => 'recipes#search_recipes'
get '/recipes/search_ingredients' => 'recipes#multiple_ingredients_search'
get '/recipes/search_results' => 'recipes#search_results', :as => "search_results"

end
