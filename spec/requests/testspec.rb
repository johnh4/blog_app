require 'spec_helper'

describe "PostPages2" do
	let!(:user) { FactoryGirl.create(:user, email: "test@example.com") }
	let!(:forum) { FactoryGirl.create(:forum) }
	let(:topic) { FactoryGirl.create(:topic, user: user, title: "fact title") }
	let(:post) { FactoryGirl.create(:post, user: user, topic: topic) }

	subject { post }

	describe "forum index" do
		before { visit forums_path }

		it { page.should have_content(forum.name) }
	end
end