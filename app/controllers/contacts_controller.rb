class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(secure_params)

    if @contact.valid?
      @contact.save
      UserMailer.contact_email(@contact).deliver_now
      flash[:notice] = "Message sent from #{@contact.first_name}."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def secure_params
    params.require(:contact).permit(:first_name, :last_name, :phone_number, :email, :content)
  end

end
