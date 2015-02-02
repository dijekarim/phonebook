require 'rails_helper'

RSpec.describe Phone, :type => :model do
  it "has none to begin with" do
    expect(Phone.count).to eq 0
  end

  it "has one after adding one" do
    FactoryGirl.create(:phone)
    expect(Phone.count).to eq 1
  end

  it "has none after one was created in a previous example" do
    expect(Phone.count).to eq 0
  end
end
