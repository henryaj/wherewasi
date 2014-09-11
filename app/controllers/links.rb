get '/links/new' do
	erb :"links/new"
end

post '/links' do 
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
		Tag.first_or_create(:text => tag)
	end
	Link.create(:url => url, :title => title, :tags => tags)
	flash[:notice] = "Link added."
	redirect to('/')
end