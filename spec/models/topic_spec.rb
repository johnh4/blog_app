require 'spec_helper'

describe Topic do
	let(:user) { FactoryGirl.create(:user, email: "testthis@email.org") }
	let(:forum) { FactoryGirl.create(:forum) }
	let(:topic) { FactoryGirl.create(:topic, title: "topic's test title",
									  user: user, forum: forum, last_post_at: Time.now) }
	let(:post) { FactoryGirl.create(:post, topic: topic) }
	before{ topic.save }
	subject { topic }

	it { should respond_to(:title) }
	it { should respond_to(:user) }
	it { should respond_to(:forum) }
	it { should respond_to(:last_post_at) }
	its(:user) { should eq(user) }
	its(:forum) { should == forum }

	it { should be_valid }
	it { should_not be_nil }
	it { topic.last_post_at.should_not be_nil }
end
