require 'rails_helper'

RSpec.describe ContactsController, :type => :controller do
  before(:each) do
    @contact = FactoryGirl.create(:contact)
    sign_in @contact.user
  end

  describe "GET index" do
    it "assigns @contacts" do
      get :index
      expect(assigns(:contacts)).to eq([@contact])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "assigns the requested contact to @contact" do 
      get :show, id: @contact.id 
      expect(assigns(:contact)).to eq(@contact) 
    end 

    it "renders the #show view" do 
      get :show, id: @contact
      expect(response).to render_template :show 
    end 
  end

  describe "POST create" do 
    context "with valid attributes" do 
      it "creates a new contact" do 
        expect{ post :create, 
                contact: FactoryGirl.attributes_for(:contact) 
        }.to change(Contact,:count).by(1) 
      end 

      it "redirects to the new contact" do 
        post :create, contact: FactoryGirl.attributes_for(:contact) 
        expect(response).to redirect_to :contacts 
      end 
    end 

    context "with invalid attributes" do 
      it "does not save the new contact" do 
        expect{ post :create, 
                contact: FactoryGirl.attributes_for(:invalid_contact)
         }.to_not change(Contact,:count) 
      end 

      it "re-renders the new method" do 
        post :create, contact: FactoryGirl.attributes_for(:invalid_contact) 
        expect(response).to render_template :new 
      end 
    end 
  end

  describe "PUT update" do
    context "valid attributes" do 
      it "located the requested @contact" do 
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:contact) 
        expect(assigns(:contact)).to eq(@contact) 
      end 

      it "changes @contact's attributes" do 
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:contact, name: "Larry") 
        @contact.reload 
        expect(@contact.name).to eq("Larry") 
      end 

      it "redirects to the updated contact" do 
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:contact) 
        expect(response).to redirect_to :contacts 
      end 
    end

    context "invalid attributes" do 
      it "locates the requested @contact" do 
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:invalid_contact) 
        expect(assigns(:contact)).to eq(@contact) 
      end 
      
      it "change @contact's attributes" do 
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:contact, name: "Larry", addr: nil) 
        @contact.reload 
        expect(@contact.name).to eq("Larry") 
        expect(@contact.addr).to_not eq("Surabaya") 
      end 

      it "re-renders the edit method" do 
        put :update, id: @contact, contact: FactoryGirl.attributes_for(:invalid_contact) 
        expect(response).to render_template :edit 
      end 
    end
  end

  describe 'DELETE destroy' do 
    it "deletes the contact" do 
      expect{ delete :destroy, 
              id: @contact
       }.to change(Contact,:count).by(-1) 
    end 

    it "redirects to contacts#index" do 
      delete :destroy, id: @contact 
      expect(response).to redirect_to contacts_url 
    end 
  end
end
