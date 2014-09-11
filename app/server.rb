require 'sinatra'
require 'data_mapper'
require 'sinatra/flash'
require 'mailgun'
require_relative './models/link'
require_relative './models/tag'
require_relative './models/user'
require_relative './mailers/mailer'
require_relative 'data_mapper_setup'
require_relative 'helpers/application'

require_relative 'controllers/application'
require_relative './controllers/links'
require_relative './controllers/sessions'
require_relative './controllers/tags'
require_relative './controllers/users'

enable :sessions
set :session_secret, 'super secret'
enable :show_exceptions

before do 
	@links = Link.all
end

# run Sinatra::Application.run!