require_relative '../app/mailers/mailer'

describe Mailer do 

	let(:mailer) { Mailer.new   }
	let(:user)   { double :user, :email => "test@test.com", :password_token => "NVJFMRKDIJ"}

	it "has a mailgun client on initialization" do 
		expect(mailer.client.class).to be Mailgun::Client 
	end
	it "has a mailgun sending domain on intialization" do 
		expect(mailer.sending_domain).to eq ENV['MAILGUN_SENDING_DOMAIN']
	end

	it "has a method for sending emails" do
		expect(mailer.client).to respond_to(:send_message)
	end

	it "can send a user's password token if they have one" do
		message_params = {:from => "noreply@wherewasi.com",
						  :to => "test@test.com",
						  :subject => "Password reset token",
						  :body => "Hi there test@test.com. Your password reset token is NVJFMRKDIJ."
						  }
		sending_domain = "domaaaain"
		expect(mailer.client).to receive(:send_message).with(mailer.sending_domain, message_params)
		mailer.send_password_reset(user)
	end

end