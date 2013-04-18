require 'spec_helper'

describe BlogPost do
  let (:user) { FactoryGirl.create(:user) }
  before { @blog_post = user.blog_posts.build(content: "First Post!", 
  											   title: "First Title") }

  subject { @blog_post }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:title) }
  its(:user) { should == user }

  describe "when user_id is not present" do
  	before { @blog_post.user_id = nil }
  	it { should_not be_valid }
  end

  describe "with no content" do
  	before { @blog_post.content = " " }
  	it { should_not be_valid }
  end
end
