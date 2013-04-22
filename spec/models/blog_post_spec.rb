require 'spec_helper'

describe BlogPost do
  let (:user) { FactoryGirl.create(:user) }
  before { @blog_post = user.blog_posts.build(content: "First Post!", 
  											   title: "First Title") }
  let(:c1) { FactoryGirl.create(:comment, user: user, blog_post: @blog_post, 
                                                      content: "First!") }
  let(:c2) { FactoryGirl.create(:comment, user: user, blog_post: @blog_post, 
                                                      content: "Second!") }

  subject { @blog_post }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:title) }
  its(:user) { should == user }
  its(:comments) { should == [c1, c2] }

  describe "when user_id is not present" do
  	before { @blog_post.user_id = nil }
  	it { should_not be_valid }
  end

  describe "with no content" do
  	before { @blog_post.content = " " }
  	it { should_not be_valid }
  end

  describe "comments" do
    

  end
end
