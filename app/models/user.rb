require 'bcrypt'

class User

	include DataMapper::Resource

	attr_accessor :password_confirmation, :password

	validates_confirmation_of :password

	property :password_token, String, unique:true
	property :password_token_timestamp, DateTime
	property :id, Serial
	property :email, String, unique:true, message: "This email is already taken"

	property :password_digest, Text

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email,password)

		user = first(:email => email)

		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else 
			nil
		end
	end
end