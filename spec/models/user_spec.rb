require 'rails_helper'

RSpec.describe User, :type => :model do
  it "Should Pass add invalid user" do
    user = FactoryGirl.build(:user, :username=>'')
    user.valid?
    expect(User.count).to eq 0
  end

  it "should pass add valid user" do
  	user = FactoryGirl.create(:user, 
                              :username=>'asd', 
                              :password => 'qwerasdf', 
                              :password_confirmation => 'qwerasdf', 
                              :admin => false)
  	user.valid?
  	expect(User.count).to eq 1
  end

  it "should pass add valid admin" do
    user = FactoryGirl.create(:user, 
                              :username=>'admin', 
                              :password => 'qwerasdf', 
                              :password_confirmation => 'qwerasdf', 
                              :admin => true)
    user.valid?
    expect(User.count).to eq 1
  end
end