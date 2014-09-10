require 'spec_helper'

describe Link do


	context "Demonstration of how datamapper works" do

		it 'should be created and then retrieved from the db' do
			# There should be no links to begin with
			expect(Link.count).to eq(0)
			
			# Adding a link, expect the db to have 1 link
			Link.create(:title => "Makers Academy",
						:url => "http://www.makersacademy.com")
			expect(Link.count).to eq(1)
			
			# Expect the first link to contain specific values
			link = Link.first
			expect(link.title).to eq("Makers Academy")
			expect(link.url).to eq("http://www.makersacademy.com")

			# Deleting a link
			link.destroy
			expect(Link.count).to eq(0)
		end

		it "should pre procces urls" do 
			Link.create(:title => "Makers Academy",
			:url => "www.makersacademy.com")
			link = Link.first
			expect(link.url).to eq("http://www.makersacademy.com")
		end

	end

end
