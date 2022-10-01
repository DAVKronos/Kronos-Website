class UserMailer < ActionMailer::Base
  default from: "Kronos <webmaster@kronos.nl>"
  
  def welcome_email(user, password)
      @user = user
      @url  = "https://kronos.nl"
      @password = password
      mail(:to => user.email, :subject => "Welkom bij Kronos")
    end
end
