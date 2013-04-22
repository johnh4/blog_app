require 'spec_helper'

describe Comment do
  let(:user) { FactoryGirl.create(:user) }
  let(:b1) { FactoryGirl.create(:blog_post, user: user, content: "Blog post content!") }
  let(:c1) { FactoryGirl.create(:comment, user: user, blog_post: b1, content: "First! Comment!") }

  subject { c1 }

  describe "associations" do

    it { should respond_to(:content) }
    it { should respond_to(:user_id) }
    it {should respond_to(:blog_post) }
    it { should respond_to(:blog_post_id) }
    its(:user) { should == user }
    its(:blog_post) { should == b1 }

  end

end
