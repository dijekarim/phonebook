class ContactsController < ApplicationController
  load_and_authorize_resource
  def index
	@contacts = Contact.accessible_by(current_ability)
	@users = User.all
  end

  def show
	@contact = Contact.find(params[:id])
  end
	
  def new 
	@contact = Contact.new
	@users = User.all
  end

  def edit
	@contact = Contact.find(params[:id])
	@users = User.all
	authorize! :edit, @contact
  end

  def update
    @contact = Contact.find(params[:id])
	@contact.assign_attributes(contact_params)
	authorize! :update, @contact

	if @contact.update(contact_params)
  	  @contacts = Contact.accessible_by(current_ability)
	  redirect_to contacts_path
	else
	  render 'edit'
	end
  end

  def create
	@contact = Contact.new(contact_params)
	if @contact.user == nil
	  @contact.user = current_user
	else
	  @contact.user.id = :user_id
	end
	authorize! :create, @contact
 
  	if @contact.save
  	  @contacts = Contact.accessible_by(current_ability)
  	  redirect_to contacts_path
  	else
  	  render 'new'
  	end
  end

  def destroy
    @contact = Contact.find(params[:id])
	authorize! :destroy, @contact
	@contact.destroy
	@contacts = Contact.accessible_by(current_ability)
	redirect_to contacts_path
  end

  private
    def contact_params
	  params.require(:contact).permit(:name, :phone_number, :addr, :user_id)
	end
end
