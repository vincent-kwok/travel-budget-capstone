class V1::TripsController < ApplicationController
  # before_action :authenticate_admin
  # before_action :authenticate_user
  
  # def index
  #   # trips = current_user.trips
  #   trips = Trip.all
  #   render json: trips.as_json
  # end

  def create
    trip = Trip.new(
      user_id: current_user.id,
      city: params[:city],
      state: params[:state],
      start_date: params[:start_date],
      end_date: params[:end_date],
      budget_flight: params[:budget_flight],
      budget_accom: params[:budget_accom],
      budget_food: params[:budget_food],
      budget_fun: params[:budget_fun],
    )
    if trip.save
      render json: trip.as_json
    else
      render json: {errors: trip.errors.full_messages}, status: :unprocessable_entity    
    end
  end

  def show
    trip_id = params["id"]
    trip = Trip.find_by(id: trip_id)
    render json: trip.as_json
  end

  # def show
  #   trip = Trip.find_by(id: params[:id])
  #   # render trip.as_json_with_recommendations
  # end

  def update
    trip = Trip.find_by(id: params[:id])
    trip.city = params[:city] || trip.city
    trip.state = params[:state] || trip.state
    trip.start_date = params[:start_date] || trip.start_date
    trip.end_date = params[:end_date] || trip.end_date
    trip.budget_flight = params[:budget_flight] || trip.budget_flight
    trip.budget_accom = params[:budget_accom] || trip.budget_accom
    trip.budget_food = params[:budget_food] || trip.budget_food
    trip.budget_fun = params[:budget_fun] || trip.budget_fun
    if trip.save
      render json: trip.as_json
    else
      render json: {errors: trip.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    trip = Trip.find_by(id: params[:id])
    trip.destroy
    render json: {message: "Trip has been deleted."}
  end

  def index

    source = "LGA"
    destination = "MDW"
    dateofdeparture = "20180701"
    dateofarrival = "20180707"
    # seatingclass: economy: E, business: B
    seatingclass = "E"
    adults = "1"
    children = "0"
    infants = "0"
    # counter: domestic = 100, international = 0)
    counter = "100"

    response = Unirest.get("http://developer.goibibo.com/api/search/?app_id=32e4551b&app_key=5a51d0b0ff157bae5674f87076e24c92&format=json&source=#{source}&destination=#{destination}&dateofdeparture=#{dateofdeparture}&dateofarrival=#{dateofarrival}&seatingclass=#{seatingclass}&adults=#{adults}&children=#{children}&infants=#{infants}&counter=#{counter}")
    
    # 5.times do
    #   x = 1
    #   flights << response.body["data"]["onwardflights"][x]["fare"]["adulttotalfare"]
    #   flights << response.body["data"]
    #   x += 1
    # end

    render json: response.body["data"]
  end

end