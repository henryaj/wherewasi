class Link 

	include DataMapper::Resource

	has n, :tags, :through => Resource
	# this sets up Link to have a many-to-many relationship with Tag
	
	property :id, 		Serial
	property :title,	String
	property :url,		String 


end 