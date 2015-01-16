class ContactsController < ApplicationController

	def index
		@contacts = Contact.accessible_by(current_ability)
	end

	def show
		@contact = Contact.find(params[:id])
	end
	
	def new 
		@contact = Contact.new
	end

	def edit
		@contact = Contact.find(params[:id])
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
		@contact.user = current_user
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
	    params.require(:contact).permit(:name, :phone_number, :addr)
	  end
end