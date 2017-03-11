class Contact < MailForm::Base
  attribute :name,        :validate => true
  attribute :email,       :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :destination, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :nickname,    :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => 'Bericht via Kronos.nl',
        :to => %(#{destination}),
        :from => %("#{name}" <#{email}>)
    }
  end
end