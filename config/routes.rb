Rails.application.routes.draw do

root :to => 'pages#home'
get '/recipes' => 'pages#index'


 
end
