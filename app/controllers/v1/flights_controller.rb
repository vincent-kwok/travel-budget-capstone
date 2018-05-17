class V1::FlightsController < ApplicationController
  def index
    source = params[:home_airport]
    destination = params[:destination_airport]
    dateofdeparture = params[:start_date].tr('-', '')
    dateofarrival = params[:end_date].tr('-', '')

    # seatingclass: economy: E, business: B
    seatingclass = "E"
    adults = "1"
    children = "0"
    infants = "0"
    # counter: domestic = 100, international = 0)
    counter = "100"

    response = Unirest.get("http://developer.goibibo.com/api/search/?app_id=#{ENV['app_id']}&app_key=#{ENV['app_key']}&format=json&source=#{source}&destination=#{destination}&dateofdeparture=#{dateofdeparture}&dateofarrival=#{dateofarrival}&seatingclass=#{seatingclass}&adults=#{adults}&children=#{children}&infants=#{infants}&counter=#{counter}")
    flights = []

    data = response.body["data"]["onwardflights"]

    3.times do |i|
      flights << {
        "Airline" => response.body["data"]["onwardflights"][i]["airline"],
        "Departure Time" => response.body["data"]["onwardflights"][i]["deptime"],
        "Arrival Time" => response.body["data"]["onwardflights"][i]["arrtime"],
        "Fare" => response.body["data"]["onwardflights"][i]["fare"]["totalfare"],
      }
    end
    # if flights.as_json
    render json: flights.as_json
    # else
    #   render json: {message: "no flights found."}
    # end
  end
end
