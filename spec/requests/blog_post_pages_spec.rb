require 'spec_helper'

describe "BlogPostPages" do

  let(:user) { FactoryGirl.create(:user) }
  let!(:b1) { FactoryGirl.create(:blog_post, user: user) }
  let!(:c1) { FactoryGirl.create(:comment, user: user, blog_post: b1) }

	subject { page }

  describe "index page" do

  	before { visit blogposts_path }

  	describe "displays content, title, and comment count" do
  		it { should have_content(b1.content) }
  		it { should have_content(b1.title) }
  		it { should have_content(b1.comments.count) }
  	end
  end
  describe "comments page for a blog post" do

  	before { visit blog_post_comments_path(b1) }

  	it { should have_content(c1.content) }	
    it { should have_link(b1.user.name, href: user_path(user)) }
  end

  describe "new blog post page" do
    before { visit new_blog_post_path }

    it { should have_button('Create blog post') }

    it "with invalid info" do
      expect { click_button 'Create blog post' }.to change(BlogPost, :count).by(0)
    end

    describe "with valid info" do
      before do
        #fill_in "User",   with: 1
        fill_in "Title",  with: "Blog Post Title"
        fill_in "Content", with: "Blog Post Content."
      end
      it "should create blog post" do
        expect { click_button 'Create blog post' }.to change(BlogPost, :count).by(1)
      end
    end
  end
end
