require 'rails_helper'
require 'database_cleaner'

feature 'User', :js => true do

  user = FactoryGirl.create(:user)

  scenario 'New user' do
    visit root_path
    click_link 'Sign up'
    fill_in 'Username', with: user.username
    fill_in 'Email address', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password Confirmation', with: user.password
    click_button 'Sign up'
    expect(page).to have_content 'successfully'
  end

  scenario 'Login and Create Contacts' do
    sign_in_with user.username, user.password
    expect(page).to have_link 'New Contact'
    expect {
      click_link 'New Contact'
      fill_in 'Name',with: Faker::Name.name
      fill_in 'Phone Number',with: '08978364758'
      fill_in 'Address',with: Faker::Address.city
      click_button 'Create Contact'
    }.to change(Contact,:count).by(1)
    expect(page).to have_content '08978364758'
  end

  scenario 'Edit profile change password' do
    sign_in_with user.username, user.password
    click_link 'Edit profile'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'Current Password', with: user.password
    click_button 'Update'
    expect(page).to have_content 'Your account has been updated successfully.'
  end

  scenario 'Cancel Account' do
    sign_in_with user.username, 'password'
    click_link 'Edit profile'
    click_button 'Cancel my account'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  private
  def sign_in_with(username, password)
    visit root_path
    fill_in 'Username or Email', with: username
    fill_in 'Password', with: password
    click_button 'Log in'

    expect(page).to have_content 'successfully'
    within 'h3' do
      expect(page).to have_content username
    end
  end
end