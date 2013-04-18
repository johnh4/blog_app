require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:p1) { FactoryGirl.create(:blog_post, user: user, 
                                    content: "First Post", title: "First Title") }
    let!(:p2) { FactoryGirl.create(:blog_post, user: user, 
                                    content: "Second Post", title: "Second Title") }

    before { visit root_path }
    it "should have the content 'Blog App'" do
      
      should have_content('Blog App')
    end
    
  describe "About page" do
  	it "should have the content 'About" do
  		visit about_path
  		should have_content('About')
  	end
  end
  
end