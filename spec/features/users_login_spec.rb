require 'rails_helper'

feature "User Login" do
  let(:existing_user) { User.create(email: "test@chocolate.sweet", password: "eat") }

  scenario "User successfully logins" do
    visit login_path
    fill_in 'Email', with: existing_user.email
    fill_in 'Password', with: existing_user.password
    click_button 'Login'

    expect(page).to have_content "Welcome back"
  end

  scenario "User failed to login" do
    visit login_path
    fill_in 'Email', with: existing_user.email
    fill_in 'Password', with: 'wrong_password'
    click_button 'Login'

    expect(page).to have_content "Login failed"
  end
end
