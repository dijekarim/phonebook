require 'rails_helper'

RSpec.describe PhonesController, :type => :controller do
  before(:each) do
    @phone = FactoryGirl.create(:phone)
    sign_in @phone.contact.user
  end

  describe "POST create" do 
    context "with valid attributes" do 
      it "creates a new phone" do 
        expect{ post :create, 
        		contact_id: @phone.contact,
        		phone: FactoryGirl.attributes_for(:phone)
        }.to change(Phone,:count).by(1) 
      end 

      it "redirects to the new phone" do 
        post :create, contact_id: @phone.contact, phone: FactoryGirl.attributes_for(:phone) 
        expect(response).to redirect_to contact_path(@phone.contact) 
      end 
    end 

    context "with invalid attributes" do 
      it "does not save the new phone" do 
        expect{ post :create, 
        		contact_id: @phone.contact, 
        		phone: FactoryGirl.attributes_for(:invalid_phone)
         }.to_not change(Phone,:count) 
      end
    end
  end

  describe 'DELETE destroy' do 
    it "deletes the phone" do 
      expect{ delete :destroy, 
        	  contact_id: @phone.contact, 
        	  id: @phone
      }.to change(Phone,:count).by(-1) 
    end 

    it "redirects to contacts#index" do 
      delete :destroy, contact_id: @phone.contact, id: @phone 
      expect(response).to redirect_to contact_path(@phone.contact)
    end 
  end
end
