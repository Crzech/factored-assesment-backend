class PasswordsController < ApplicationController
  skip_before_action :authenticate_request

  def forgot
    return render json: { error: "Email not present" } if params[:email].blank?

    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_token!
      # TODO: Configure smtp for production
      # not configured 'cause it's a lot of effort for this kind of app
      # default token: 0a40b92c9558d5e11f3e
      UserMailer.recover_password_email(user).deliver_now
      render json: { status: "ok" }, status: :ok
    else
      render json: {
               error: ["Email address not found. Please check and try again."],
             },
             status: :not_found
    end
  end

  def reset
    token = params[:token].to_s

    return render json: { error: "Token not present" } if params[:token].blank?
    return render json: { error: "Password not present" } if params[:password].blank?

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: { status: "ok" }, status: :ok
      else
        render json: {
                 error: user.errors.full_messages,
               },
               status: :unprocessable_entity
      end
    else
      render json: {
               error: ["Link not valid or expired. Try generating a new link."],
             },
             status: :not_found
    end
  end
end
