class PhonesController < ApplicationController
  def create
    @contact = Contact.find(params[:contact_id])
    @phone = @contact.phone.create(phone_params)
    redirect_to contact_path(@contact)
  end
  
  def destroy
    @contact = Contact.find(params[:contact_id])
    @phone = @contact.phone.find(params[:id])
    @phone.destroy
    redirect_to contact_path(@contact)
  end

  private
  def phone_params
    params.require(:phone).permit(:more_phone)
  end
end
