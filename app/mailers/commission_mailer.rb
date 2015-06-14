class CommissionMailer < ActionMailer::Base
  default from: "webmaster@kronos.nl"
  
  def subscription_email(agendaitem, username, user)
    return unless commission_email_exists?(agendaitem)
    @user = user
    @username = username
    @url  ='https://kronos.nl'
    @agendaitem = agendaitem
    mail(:to => @agendaitem.commission.email, :subject => "Nieuwe inschrijving") 
  end

  private

  def commission_email_exists?(agendaitem)
    return (!agendaitem.commission.nil?) && agendaitem.commission.present? && agendaitem.commission.email.present?
  end

end
