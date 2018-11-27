class V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users.as_json
  end

  def create
    user = User.new(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      admin: false
    )
    if user.save
      render json: {message: "User created successfully"}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: :bad_request
    end
  end

  def show
    user_id = params["id"]
    user = Trip.find_by(id: user_id)
    render json: user.as_json
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    render json: {message: "User has been deleted."}
  end
  
end