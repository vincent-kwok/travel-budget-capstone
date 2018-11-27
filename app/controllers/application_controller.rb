class ApplicationController < ActionController::API
  include Knock::Authenticable

  def authenicate_admin
    unless current_user && current_user.authenicate_admin
      render json: {}, status: :unauthorized
    end
  end
end
