require_relative 'helpers/session'
require 'spec_helper'

feature 'recovering a password' do

	include SessionHelpers

	before(:each) do
		User.create(:email => "test@test.com",
								:password => "test",
								:password_confirmation => "test")
	end

	scenario 'requesting a password reset token' do
		request_reset_password
		expect(page).to have_content("Your password reset token has been emailed to you")
	end

	scenario 'producing a password reset token' do
		request_reset_password
		user = User.first(:email => "test@test.com")
		expect(user.password_token.class).to be(String)
		expect(user.password_token.length).to be(10)
	end

	scenario 'when visiting the password reset link' do
		request_reset_password

		user = User.first(:email => "test@test.com")
		token = user.password_token
		visit "/users/reset_password/#{token}"
		expect(page).to have_content("Hello, #{user.email}! Please reset your password")
	end

	scenario "resetting the password" do 
		request_reset_password
		
		user = User.first(:email => "test@test.com")
		token = user.password_token
		
		visit "/users/reset_password/#{token}"
		fill_in "new_password", with: "sheeps"
		fill_in :password_confirmation, :with => "sheeps"
		click_button "Confirm new password"

		expect(User.authenticate("test@test.com", "sheeps")).to eq(user)
		
		# visit "/sessions/new"
		# fill_in 'email', :with => "test@test.com"
		# fill_in 'password', :with => "sheep"
		# click_button 'Sign in'
		# expect(page).to have_content("Welcome, #{user.email}")
	end

end