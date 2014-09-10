post '/links' do 
	url = params["url"]
	# url = "http://" + url unless url.start_with?
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
		Tag.first_or_create(:text => tag)
	end
	Link.create(:url => url, :title => title, :tags => tags)
	redirect to('/')
end