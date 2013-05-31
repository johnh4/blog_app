require 'spec_helper'

describe Post do
	let!(:user) { FactoryGirl.create(:user, email: "test@example.com") }
	let!(:forum) { FactoryGirl.create(:forum) }
	let(:topic) { FactoryGirl.create(:topic, user: user, title: "fact title") }
	let(:post) { FactoryGirl.create(:post, user: user, topic: topic) }

	subject { post }

	it { should respond_to(:content) }
	its(:topic) { should == topic }
	its(:user) { should == user }
end
