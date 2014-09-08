require 'sinatra'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

# sets up the default database
# depending on what environment we're in
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link'

DataMapper.finalize

DataMapper.auto_upgrade!

class WhereWasI < Sinatra::Base

	get '/' do 
		@links = Link.all
		erb :index
	end
	


end