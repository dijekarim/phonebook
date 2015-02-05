module Features
  module SessionHelpers
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
  end
end