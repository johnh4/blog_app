require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Blog App'" do
      visit '/static_pages/home'
      page.should have_content('Blog App')
    end
  end

  describe "About page" do
  	it "should have the content 'About" do
  		visit '/static_pages/about'
  		page.should have_content('About')
  	end
  end
  
end