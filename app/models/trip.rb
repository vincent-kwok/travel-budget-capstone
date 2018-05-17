class Trip < ApplicationRecord
  belongs_to :user
  has_many :expenses

# list of expenses by categories
  def travel_expenses
    expenses.select {|expense| expense.category == "travel"}
  end

  def accom_expenses
    expenses.select {|expense| expense.category == "accommodation"}
  end

  def food_expenses
    expenses.select {|expense| expense.category == "food"}
  end

  def entertainment_expenses
    expenses.select {|expense| expense.category == "entertainment"}
  end

# total expenses by categories
  def actual_travel
    actual_travel = travel_expenses.reduce(0) {|sum, expense| sum += expense.amount }
  end

  def actual_accom
    actual_accom = accom_expenses.reduce(0) {|sum, expense| sum += expense.amount }
  end

  def actual_food
    actual_food = food_expenses.reduce(0) {|sum, expense| sum += expense.amount }
  end

  def actual_entertainment
    actual_entertainment = entertainment_expenses.reduce(0) {|sum, expense| sum += expense.amount }
  end

  def actual_expenses
    actual_expenses = actual_travel + actual_accom + actual_food + actual_entertainment
  end

# ratios of actual over budgeted
  def travel_ratio
    travel_ratio = actual_travel * 100 / budget_flight
  end

  def accom_ratio
    accom_ratio = actual_accom * 100 / budget_accom
  end

  def food_ratio
    food_ratio = actual_food * 100 / budget_food
  end

  def entertainment_ratio
    entertainment_ratio = actual_entertainment * 100 / budget_fun
  end

  def budget_total
    budget_total = budget_flight + budget_accom + budget_food + budget_fun
  end

  def actual_ratio
    actual_ratio = actual_expenses * 100 / budget_total
  end
  
  def as_json
    {
      id: id,
      destination: destination,
      home_airport: home_airport,
      destination_airport: destination_airport,
      start_date: start_date,
      end_date: end_date,

      budget_flight: budget_flight,
      budget_accom: budget_accom,
      budget_food: budget_food,
      budget_fun: budget_fun,
      
      actual_travel: actual_travel,
      actual_accom: actual_accom,
      actual_food: actual_food,
      actual_entertainment: actual_entertainment,
      actual_expenses: actual_expenses,

      travel_ratio: travel_ratio,
      accom_ratio: accom_ratio,
      food_ratio: food_ratio,
      entertainment_ratio: entertainment_ratio,
      budget_total: budget_total,
      actual_ratio: actual_ratio,
    }
  end
end