# == Route Map
#
#                     Prefix Verb   URI Pattern                           Controller#Action
#                      login GET    /login(.:format)                      sessions#new
#                            POST   /login(.:format)                      sessions#create
#                            DELETE /login(.:format)                      sessions#destroy
#                       root GET    /                                     recipes#home
#             recipes_search GET    /recipes/search(.:format)             recipes#search_recipes
# recipes_search_ingredients GET    /recipes/search_ingredients(.:format) recipes#multiple_ingredients_search
#             search_results GET    /recipes/search_results(.:format)     recipes#search_results
#                 edit_users GET    /users/edit(.:format)                 users#edit
#                      users GET    /users(.:format)                      users#index
#                            POST   /users(.:format)                      users#create
#                   new_user GET    /users/new(.:format)                  users#new
#                       user GET    /users/:id(.:format)                  users#show
#                            PATCH  /users/:id(.:format)                  users#update
#                            PUT    /users/:id(.:format)                  users#update
#                            DELETE /users/:id(.:format)                  users#destroy
#

Rails.application.routes.draw do

  get '/login' => 'sessions#new' 
  post '/login' => 'sessions#create'
  delete '/login' => 'sessions#destroy'

root :to => 'recipes#home'

get '/recipes/search' => 'recipes#search_recipes'
get '/recipes/search_ingredients' => 'recipes#multiple_ingredients_search'
get '/recipes/search_results' => 'recipes#search_results', :as => "search_results"

resources :users, :except => [:edit] do
    collection do
      get '/edit' => 'users#edit'
    end
  end

post 'users/favorite' => 'users#favorite'

end
