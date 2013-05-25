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
    before do
      visit post_path
    end    

    it { should_not have_button('Create blog post') }

    describe "when signed in" do
      before do
        sign_in user
        visit post_path
      end

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
end
