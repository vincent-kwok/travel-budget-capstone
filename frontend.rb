require "unirest"
require "io/console"

system "clear"

puts "(A) Create a user"
puts "(B) Log in"
puts "(C) Log out"
puts "(1) View all trips"
puts "(2) Create a trip"
puts "(3) Show a trip"
puts "(4) Update a trip"
puts "(5) Delete a trip"

input_option = gets.chomp

if input_option == "A"
  # create a user
  params = {}
  print "email: "
  params[:email] = gets.chomp
  print "password: "
  params[:password] = gets.chomp
  print "confirm password: "
  params[:password_confirmation] = gets.chomp
  params[:admin] = false
  response = Unirest.post(
    "http://localhost:3000/v1/users", 
    parameters: params
  )
  user = response.body
  puts JSON.pretty_generate(user)
elsif input_option == "B"
  # log in user
  response = Unirest.post(
    "http://localhost:3000/user_token", 
      parameters: { 
      auth: {
        email: "vince@email.com",
        password: "password",
      }
    }
  )
  # Save the JSON web token from the response
  jwt = response.body[​"jwt"]
  # Include the jwt in the headers of any future web requests 
  Unirest.default_header(​"Authorization", "Bearer ​#{jwt}​")
elsif input_option == "C"
  # log out user
  if current_user
    trips = current_user.trips
    render json: trips.as_json
  else
    render json: []
  end
elsif input_option == "1"
  # view all trips
  response = Unirest.get("http://localhost:3000/v1/trips")
  trips = response.body
  puts JSON.pretty_generate(trips)
elsif input_option == "2"
  # create a trip
  params = {}
  print "user_id: "
  params[:user_id] = gets.chomp
  print "city: "
  params[:city] = gets.chomp
  print "state: "
  params[:state] = gets.chomp
  print "start date (yyyy-mm-dd): "
  params[:start_date] = gets.chomp
  print "end date (yyyy-mm-dd): "
  params[:end_date] = gets.chomp
  print "budget flight: "
  params[:budget_flight] = gets.chomp
  print "budget accommodations: "
  params[:budget_accom] = gets.chomp
  print "budget food: "
  params[:budget_food] = gets.chomp
  print "budget fun: "
  params[:budget_fun] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/trips", parameters: params)
  trip = response.body
  puts JSON.pretty_generate(trip)
elsif input_option == "3"
  # show a trip
  print "Enter a trip ID: "
  trip_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/trips/#{trip_id}")
  trip = response.body
  puts JSON.pretty_generate(trip)
elsif input_option == "4"
  # update a trip
  print "Enter a trip ID: "
  trip_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/trips/#{trip_id}")
  trip = response.body
  params = {}
  print "Trip city (#{trip["city"]}): "
  params[:city] = gets.chomp
  print "Trip state (#{trip["state"]}): "
  params[:state] = gets.chomp
  print "Trip start date (#{trip["start_date"]}): "
  params[:start_date] = gets.chomp
  print "Trip end date (#{trip["end_date"]}): "
  params[:end_date] = gets.chomp

  print "Budget for flight (#{trip["budget_flight"]}): "
  params[:budget_flight] = gets.chomp
  print "Budget for accommodations (#{trip["budget_accom"]}): "
  params[:budget_accom] = gets.chomp  
  print "Budget for food (#{trip["budget_food"]}): "
  params[:budget_food] = gets.chomp  
  print "Budget for fun (#{trip["budget_fun"]}): "
  params[:budget_fun] = gets.chomp

  response = Unirest.patch("http://localhost:3000/v1/trips/#{trip_id}", parameters: params)
  puts JSON.pretty_generate(response.body)
elsif input_option == "5"
  # delete a trip
  print "Enter a trip ID: "
  trip_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/trips/#{trip_id}")
  trip = response.body
  puts JSON.pretty_generate(trip)
end