class PasswordResetForOmniauthMailer < ApplicationMailer
  default from: 'example@domain.com'

  def welcome_email(user)
   @user = user
   mail(to: @user.email, subject: 'Welcome to Band Together!')
 end
end
