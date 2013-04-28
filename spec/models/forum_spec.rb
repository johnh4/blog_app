require 'spec_helper'

describe Forum do

  let(:user_1) { FactoryGirl.create(:user, email: "testing@jh.org") }
  let!(:forum) { FactoryGirl.create(:forum) }
  let!(:topic) { FactoryGirl.create(:topic, user: user_1, forum: forum, last_post_at: Time.now) }
  let!(:post) { FactoryGirl.create(:post, user: user_1, topic: topic) }

  before { @forum = Forum.new(name: "General", description: "Discuss general things.") }

  subject { @forum }

  it { should respond_to(:topics) }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:most_recent_post) }

  describe "return value of most_recent_post" do
  	let(:found_topic) { forum.most_recent_post }

  	specify { found_topic.should eq(topic) }
    specify { found_topic.should_not be_nil }
  	specify { forum.topics.first.should == topic }
    specify { forum.topics.first.should_not be_nil }
  end

  describe "last post at" do
    specify { forum.most_recent_post.last_post_at.should == topic.last_post_at }

    specify { topic.last_post_at.should_not be_nil }
    specify { forum.most_recent_post.last_post_at.should_not be_nil }
  end


end
