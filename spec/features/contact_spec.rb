require 'rails_helper'

feature 'Contact', :js => true do
  user = FactoryGirl.create(:user)

  scenario 'New user' do
    sign_up_with user.username, user.email, user.password
  end

  scenario 'Login, create and edit contact' do
    sign_in_with user.username, user.password
    create_contact 'qwe', '08978364758', 'Sda'
    create_contact 'asd2', '08978364234', 'Surabaya'
    expect(page).to have_content '08978364758'
    expect(page).to have_content '08978364234'

    #edit phone contact
    find('.table').first(:link, 'Edit').click
    fill_in 'contact_phone_number',with: '08881234098'
    click_button 'Update Contact'
    expect(page).to have_content '08881234098'
  end

  scenario 'Login, create contact invalid phone' do
    sign_in_with user.username, user.password

    #invalid phone regexp
    create_contact 'asd', '12345678901', 'Sda'
    expect(page).to have_content 'Phone number is invalid'

    #invalid too long phone
    fill_in 'Phone Number',with: '08881234098122'
    click_button 'Create Contact'
    expect(page).to have_content 'Phone number is too long'

    #invalid too short phone
    fill_in 'Phone Number',with: '08881'
    click_button 'Create Contact'
    expect(page).to have_content 'Phone number is too short'
  end

  scenario 'Login, create contact, add more phone number, destroy' do
    sign_in_with user.username, user.password

    #add contact
    create_contact 'coba add', '08137485721', 'Surabaya'
    expect(page).to have_content '08137485721'

    #tambah nomor pada contact 'coba add'
    click_link 'coba add'
    fill_in 'New Phone Number',with: '08137485231'
    expect(page).to have_content '08137485721'
    click_link 'Back'

    #destroy contact asd
    find('.table').first(:link, 'Destroy').click
    expect(page).to_not have_content 'qwe'
  end

  private
  def sign_up_with(username, email, password)
    visit root_path
    click_link 'Sign up'
    fill_in 'Username', with: username
    fill_in 'Email address', with: email
    fill_in 'Password', with: password
    fill_in 'Password Confirmation', with: password
    click_button 'Sign up'
    expect(page).to have_content 'successfully'
  end

  def sign_in_with(username, password)
    visit root_path
    fill_in 'Username or Email', with: username
    fill_in 'Password', with: password
    click_button 'Log in'

    expect(page).to have_content 'successfully'
    within 'h1' do
      expect(page).to have_content username
    end
  end

  def create_contact(name, ph, addr)
    click_link 'New Contact'
    fill_in 'Name',with: name
    fill_in 'Phone Number',with: ph
    fill_in 'Address',with: addr
    click_button 'Create Contact'
  end
end