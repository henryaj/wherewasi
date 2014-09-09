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
		visit '/sessions/new'
		click_link 'Forgot password'
		fill_in "email", with: "test@test.com"
		click_button 'Request password reset'
		expect(page).to have_content("Your password reset token has been emailed to you")
	end

	scenario 'producing a password reset token' do
		visit '/sessions/new'
		click_link 'Forgot password'
		fill_in "email", with: "test@test.com"
		click_button 'Request password reset'

		user = User.first(:email => "test@test.com")
		expect(user.password_token.class).to be(String)
		expect(user.password_token.length).to be(10)
	end

	scenario 'when visiting the password reset link' do
		visit '/sessions/new'
		click_link 'Forgot password'
		fill_in "email", with: "test@test.com"
		click_button 'Request password reset'

		user = User.first(:email => "test@test.com")
		token = user.password_token
		puts "***" * 50
		puts user.inspect
		# puts token
		visit "/users/reset_password/#{token}"
		expect(page).to have_content("Hello, #{user.email}! Your password has been reset!")
	end

end