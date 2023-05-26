class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # POST /auth/login
  def login
    @user = User.find_by_username(params[:username])
    if @user&.authenticate(params[:password])
      token = jwt_enconde(user_id: @user.id, email: @user.email)
      render json: { token: token }, status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
