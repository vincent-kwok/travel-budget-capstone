Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1 do
    get "/trips" => "trips#index"
    post "/trips" => "trips#create"
    get "/trips/:id" => "trips#show"
    patch "/trips/:id" => "trips#update"
    delete "/trips/:id" => "trips#destroy"

    get "/flights" => "flights#index"
    get "/airports" => "airports#index"
    get "/hotels" => "hotels#index"
    
    get "/users" => "users#index"
    post "/users" => "users#create"

    get "/expenses" => "expenses#index"
    post "/expenses" => "expenses#create"
    get "/expenses/:id" => "expenses#show"
    patch "/expenses/:id" => "expenses#update"
    delete "/expenses/:id" => "expenses#destroy"    
  end
end