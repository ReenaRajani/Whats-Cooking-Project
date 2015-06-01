Rails.application.routes.draw do

root :to => 'recipes#home'
get '/recipes' => 'recipes#index'
 
end
