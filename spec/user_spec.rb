require 'spec_helper'

describe User do

	context "password reset process" do
		it "can have a password reset token" do
			user = User.create
			user.password_token = "ABCDEFGHI"
			expect(user.password_token).to eq("ABCDEFGHI")
		end

		it "can have a password_token_timestamp" do 
			user = User.create
			user.password_token_timestamp = Time.now
			expect(user.password_token_timestamp).to be_an_instance_of DateTime
		end

		it "the password reset token can be retrieved from a user that has one" do
			User.create(:password_token => "ABCDEFGHI")

			user = User.first
			expect(user.password_token).to eq("ABCDEFGHI")

		end

	end

end