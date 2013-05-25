require 'spec_helper'

describe "CommentPages" do

  let(:user) { FactoryGirl.create(:user) }
  let!(:b1) { FactoryGirl.create(:blog_post, user: user) }
  let!(:c1) { FactoryGirl.create(:comment, user: user, blog_post: b1) }
  
  subject { page }  

  describe "index page" do 
  	before { visit blog_post_comments_path(b1) }

  	it { should have_content(c1.content) }
  	it { should_not have_content('this should pass') }
  end

  describe "show page" do
  	before { visit blog_post_comment_path(b1,c1) }

  	it { should have_content(c1.content) }
  end

  describe "new comment page" do
  	before { visit new_blog_post_comment_path(b1) }

  	describe "when not signed in" do
  		it { should have_content "Please sign in" }
  		it { should_not have_button 'Create comment' }
  	end

  	describe "when signed in" do
  		before do
  			sign_in user
  			visit new_blog_post_comment_path(b1)
  		end

	  	describe "submitted with valid data" do
			before do
				#fill_in "User",         with: 1
				fill_in "Content",		with: "Test Comment 123"
				click_button "Create comment"
			end

			describe "should post a comment to the blog post's comments page" do
				before { visit blog_post_comments_path(b1) }
				it { should have_content("Test Comment 123") } 
			end

			describe "should post a comment to the user's page" do
				before { visit user_path(user) }
				it { should have_content("Test Comment 123") }
			end

			it "should update blog post's comment count" do
				expect do
					visit new_blog_post_comment_path(b1)
					#fill_in "User",         with: 1
					fill_in "Content",		with: "Test Comment 123"
					click_button "Create comment"
				end.to change(b1.comments, :count).by(1)
			end
	  	end
	end
  end
end
