class UserMailer < ApplicationMailer
  def recover_password_email(user)
    @user = user
    mail(to: @user.email, subject: "Recover Password Code")
  end
end
