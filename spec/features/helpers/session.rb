module SessionHelpers	
	def sign_in(email, password)
		visit '/sessions/new'
		fill_in 'email', :with => email
		fill_in 'password', :with => password
		click_button 'Sign in'
	end

	def request_reset_password(email="test@test.com")
		visit '/sessions/new'
		click_link 'Forgot password'
		fill_in "email", with: "test@test.com"
		click_button 'Request password reset'
	end
end