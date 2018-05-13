class V1::ExpensesController < ApplicationController
  def index
    # expenses = Expense.all
    expenses = Trip.find_by(id: params[:trip_id]).expenses
    render json: expenses.as_json
  end

  def create
    expense = Expense.new(
      trip_id: 2,
      category: params[:category],
      amount: params[:amount],
      description: params[:description],
    )
    if expense.save
      render json: expense.as_json
    else
      render json: {errors: expense.errors.full_messages}, status: :unprocessable_entity    
    end
  end

  def show
    expense_id = params["id"]
    expense = Expense.find_by(id: expense_id)
    render json: expense.as_json
  end

  def update
    expense = Expense.find_by(id: params[:id])
    expense.category = params[:category] || expense.category
    expense.amount = params[:amount] || expense.amount
    expense.description = params[:description] || expense.description
    if expense.save
      render json: expense.as_json
    else
      render json: {errors: expense.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    expense = Expense.find_by(id: params[:id])
    expense.destroy
    render json: {message: "Expense has been deleted."}
  end
end
