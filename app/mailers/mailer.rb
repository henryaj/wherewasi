require 'mailgun'

class Mailer

	attr_accessor :client

	def initialize
		@client = Mailgun::Client.new ENV['MAILGUN_API_KEY']
	end

	def send_password_reset(user)
		send_message(ENV['MAILGUN_SENDING_DOMAIN'],
					{:from => "noreply@wherewasi.com",
					  :to => user.email,
					  :subject => "Password reset token",
					  :body => "Hi there #{user.email}. Your password reset token is #{user.password_token}."
					})		
	end

end