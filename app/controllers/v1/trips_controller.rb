class V1::TripsController < ApplicationController
  # before_action :authenticate_admin
  before_action :authenticate_user
  
  def index
    trips = current_user.trips
    # trips = Trip.all
    render json: trips.as_json
  end

  def create
    trip = Trip.new(
      user_id: current_user.id,
      # user_id: 2,
      destination: params[:destination],
      home_airport: params[:home_airport],
      destination_airport: params[:destination_airport],
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
    trip.destination = params[:destination] || trip.destination
    trip.home_airport = params[:home_airport] || trip.home_airport
    trip.destination_airport = params[:destination_airport] || trip.destination_airport
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

end