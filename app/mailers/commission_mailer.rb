class CommissionMailer < ActionMailer::Base
  default from: "webmaster@kronos.nl"
  
  def subscription_email(agendaitem, user)
      @user = user
      @url  = "https://kronos.nl"
	  @agendaitem = agendaitem
      mail(:to => @agendaitem.commission.email, :subject => "Niewe inschrijving")
    end
end
