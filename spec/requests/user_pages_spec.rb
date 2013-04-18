require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
    let!(:p1) { FactoryGirl.create(:blog_post, user: user, 
                                    content: "First Post", title: "First Title") }
    let!(:p2) { FactoryGirl.create(:blog_post, user: user, 
                                    content: "Second Post", title: "Second Title") }

  	before { visit user_path(user) }  	

  	it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "blog posts" do
      it { should have_content(user.blog_posts.count) }
      it { should have_content(p1.content) }
      it { should have_content(p2.content) }
    end
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign Up') }
    it { should have_selector('title', text: 'Sign Up') }
  end

  describe "signup" do
    before { visit signup_path }
    let (:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
      end

      it "should create a user" do
        expect {click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end