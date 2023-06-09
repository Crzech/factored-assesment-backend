class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    if header
      decoded = jwt_decode(header)
      p decoded
      @current_user = User.find(decoded[:user_id])
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
