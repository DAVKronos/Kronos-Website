class ContactsController < Admin::ApplicationController
  load_and_authorize_resource
  
  CHAIRMAN_EMAIL = "voorzitter@kronos.nl"
  SECRETARY_EMAIL = "secretaris@kronos.nl"
  
  def new
    @contact = Contact.new
  end

  def create
    @sender = params[:contact][:email]
    @contact_params = params[:contact]
    @contact_params[:destination] = @sender
    @contact = Contact.new(@contact_params)
    
    @contact_params[:destination] = CHAIRMAN_EMAIL
    @contact_chair = Contact.new(@contact_params)
    
    @contact_params[:destination] = SECRETARY_EMAIL
    @contact_sec = Contact.new(@contact_params)
    
    
    @contact.request = request
    if verify_recaptcha(model: @contact) && @contact_chair.deliver
      @contact.deliver
      @contact_sec.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      redirect_to :root
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end
end