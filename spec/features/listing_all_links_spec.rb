require 'spec_helper'

feature "User browses the list of links" do

  before(:each) {
    Link.create(:url => "www.makersacademy.com",
                :title => "Makers Acodemy", 
                :tags => [Tag.first_or_create(:text => 'education')])
    Link.create(:url => "https://www.google.com", 
                :title => "Google", 
                :tags => [Tag.first_or_create(:text => 'search')])
    Link.create(:url => "http://www.bing.com", 
                :title => "Bing", 
                :tags => [Tag.first_or_create(:text => 'search')])
    Link.create(:url => "http://www.code.org", 
                :title => "Code.org", 
                :tags => [Tag.first_or_create(:text => 'education')])
  }



	scenario "when opening the home page" do
		visit '/'
		expect(page).to have_content("Makers Acodemy")
	end

    scenario "when opening the home page" do
        visit '/'
        expect(page).to have_link("Makers Acodemy", href: "http://www.makersacademy.com")
    end

    scenario "when opening the home page" do
        visit '/'
        click_link("Google")
        expect(page.status_code).to eq 200
    end




	scenario "filtered by a tag" do
		visit '/tags/search'
		expect(page).not_to have_content("Makers Acodemy")
		expect(page).not_to have_content("Code.org")
		expect(page).to have_content("Google")
		expect(page).to have_content("Bing")
	end

		
end