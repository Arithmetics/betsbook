class WelcomeMailer < ApplicationMailer

  def welcome_send(user)
    @user = user
    mail to: user.email, subject: "Welcome to Betsbook", from: 'admin@betsbook.com'  
  end

end
