# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "vince@email.com", password: "password", admin: true)
User.create(email: "guest@email.com", password: "password", admin: false)
User.create(email: "lynn@email.com", password: "password", admin: false)
User.create(email: "mike@email.com", password: "password", admin: false)
User.create(email: "nina@email.com", password: "password", admin: false)


Trip.create(
  user_id: 2,
  city: "boston",
  state: "ma",
  start_date: "2018-03-04",
  end_date: "2018-03-10",
  budget_flight: 400,
  budget_accom: 300,
  budget_food: 120,
  budget_fun: 600,
)

Trip.create(
  user_id: 3,
  city: "richmond",
  state: "va",
  start_date: "2018-04-01",
  end_date: "2018-04-04",
  budget_flight: 150,
  budget_accom: 120,
  budget_food: 90,
  budget_fun: 175,
)

Trip.create(
  user_id: 4,
  city: "miami",
  state: "fl",
  start_date: "2018-05-22",
  end_date: "2018-05-27",
  budget_flight: 450,
  budget_accom: 250,
  budget_food: 250,
  budget_fun: 250,
)

Trip.create(
  user_id: 2,
  city: "las vegas",
  state: "nv",
  start_date: "2018-06-02",
  end_date: "2018-06-30",
  budget_flight: 120,
  budget_accom: 3000,
  budget_food: 560,
  budget_fun: 240,
)

Trip.create(
  user_id: 4,
  city: "portland",
  state: "or",
  start_date: "2018-06-02",
  end_date: "2018-06-14",
  budget_flight: 500,
  budget_accom: 240,
  budget_food: 360,
  budget_fun: 240,
)

Trip.create(
  user_id: 3,
  city: "dallas",
  state: "tx",
  start_date: "2018-06-14",
  end_date: "2018-06-28",
  budget_flight: 700,
  budget_accom: 800,
  budget_food: 500,
  budget_fun: 2800,
)

Trip.create(
  user_id: 3,
  city: "houston",
  state: "tx",
  start_date: "2018-07-24",
  end_date: "2018-07-26",
  budget_flight: 400,
  budget_accom: 200,
  budget_food: 100,
  budget_fun: 425,
)

Trip.create(
  user_id: 2,
  city: "atlanta",
  state: "ga",
  start_date: "2018-09-15",
  end_date: "2018-09-22",
  budget_flight: 240,
  budget_accom: 700,
  budget_food: 200,
  budget_fun: 600,
)

Trip.create(
  user_id: 5,
  city: "chicago",
  state: "il",
  start_date: "2018-12-30",
  end_date: "2019-02-02",
  budget_flight: 160,
  budget_accom: 550,
  budget_food: 400,
  budget_fun: 1000,
)