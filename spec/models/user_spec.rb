require 'spec_helper'

describe User do
  
	before { @user = User.new(name: "Example User", email: "user@example.com") }

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:blog_posts) }

	describe "when name is not present" do
		before do
			@user = User.new(name: "", email: "user@example.com")
		end
		it { should_not be_valid}
	end

	describe "when email is not present" do
		before { @user.email = " "}
		it { should_not be_valid }
	end

	describe "blog post associations" do
		before { @user.save }
		let!(:older_blog_post) do
			FactoryGirl.create(:blog_post, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_blog_post) do
			FactoryGirl.create(:blog_post, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right blog posts in the right order" do
			@user.blog_posts.should == [newer_blog_post, older_blog_post]
		end
	end
end
