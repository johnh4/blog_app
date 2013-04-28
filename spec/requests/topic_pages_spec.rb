require 'spec_helper'

describe "TopicPages" do

	let(:user) { FactoryGirl.create(:user) }
	let(:forum) { FactoryGirl.create(:forum) }
	#let(:topic) { FactoryGirl.create(:topic, title: "topic's test title", 
	#	                              user: user, forum: forum) }
	subject { page }

	describe "New Topic Page" do
		before { visit new_forum_topic_path(forum) }

		describe "with valid information" do
			before do
				sign_in user
				visit new_forum_topic_path(forum) 
				fill_in "Title",     with: "Test Title"
				fill_in "post[content]",   with: "Original post content."
			end

			describe "submitting it" do

				it "should create a topic" do
					expect { click_button "Create topic" }.to change(Topic, :count).by(1)
				end

				describe "that is valid" do
					before { click_button "Create topic" }

					it { forum.topics.first.last_post_at.should_not be_nil }
				end	

				describe "the topic should have a post" do
					before { click_button "Create topic" }

					it { forum.topics.first.posts.should_not be_empty }
				end			
			end
		end
	end
end
