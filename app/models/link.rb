class Link 

	include DataMapper::Resource

	has n, :tags, :through => Resource
	# this sets up Link to have a many-to-many relationship with Tag
	
	property :id, 		Serial
	property :title,	String
	property :url,		String 

	# preprocesses URL before saving to DB
	before :save do
		unless self.url.start_with?('http://') || self.url.start_with?('https://')
			self.url = 'http://' + self.url
		end
	end

end 