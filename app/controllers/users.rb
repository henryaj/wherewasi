post '/users' do
	@user = User.new(:email => params[:email],
				:password => params[:password],
				:password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end

get '/users/new' do
	@user = User.new
	erb :"users/new"
end

post '/users/reset_password' do 
	email = params[:email]
	user = User.first(:email => email)
	user.password_token = (1..10).map{('A'..'Z').to_a.sample}.join
	user.save
	flash[:notice] = "Your password reset token has been emailed to you"
	redirect to('/sessions/new')
end

get '/users/reset_password' do 
	erb :"users/reset_password"
end

get "/users/reset_password/:token" do 
	user = User.first(:password_token => params[:token])
	session[:user_id] = user.id
	erb :"users/new_password"
end

post "/users/new_password" do 
	current_user.password  = params[:new_password] 
	current_user.password_confirmation = params[:password_confirmation]
	current_user.save
end

