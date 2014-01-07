class CommissionMailer < ActionMailer::Base
  default from: "webmaster@kronos.nl"
  
  def subscription_email(agendaitem, username, user)
      @user = user
	  @username = username
      @url  = "https://kronos.nl"
	  @agendaitem = agendaitem
      mail(:to => @agendaitem.commission.email, :subject => "Nieuwe inschrijving")
    end
end
