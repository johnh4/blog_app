require 'spec_helper'

describe "ForumPages" do
	
	before do
		@user = User.create(name: "John Doe", email: "jdoe@example.com", password: "password", 
						 password_confirmation: "password")
		@user.save
		@forum = Forum.create(name: "Test Forum 1", description: "Test description")
		@topic = @user.topics.build(title: "Test Title 1", forum_id: @forum.id, 
									last_post_at: Time.now)
		@topic.save
		#@post = @topic.posts.build(title: "Test Post 1")
		sign_in @user
	end
	subject { page }
	#let!(:forum_1) { FactoryGirl.create(:forum) }
	#let!(:forum_2) { FactoryGirl.create(:forum, name: "forum_2", description: "second forum") }
	#let!(:forum_3) { FactoryGirl.create(:forum, name: "forum_3", description: "third forum") }
	#let!(:user_a) { FactoryGirl.create(:user, email: "test2@johnhowlett.org") }
	#let!(:topic_a) { FactoryGirl.create(:topic, title: "titlea", user: user_a, forum: forum_1,
	#									 last_post_at: Time.now) }
	
	describe "Forum Index" do
		before { visit forums_path }

		it { should have_selector('title', text: "Forums") }

		describe "all forums" do
			before { @forums = Forum.all }

			specify "are displayed" do
				@forums.each do |forum|
					should have_content(forum.name)
					should have_content(forum.description)
					should have_link('Show', href: forum_path(forum))
				end
			end
		end

		describe "last posts" do
			it { should have_content("ago") }
		end
	end

	describe "individual forum" do
		#let(:user) { FactoryGirl.create(:user) }
		#let!(:topic) { FactoryGirl.create(:topic, title: "title1", user: user, forum: forum_1,
		#								 last_post_at: Time.now) }
		#let!(:topic_2) { FactoryGirl.create(:topic, title: "title2", user: user, forum: forum_1,
		#								 last_post_at: Time.now) }
		#let!(:topic_3) { FactoryGirl.create(:topic, title: "title3", user: user, forum: forum_1,
		#								 last_post_at: Time.now) }
		before do
			visit forums_path
			click_link @forum.name
			@topics = Topic.all
		end

		describe "displays all topics" do
			specify "on page" do
				@topics.each do |test_topic|
					should have_content("Replies")
					should have_link("New Topic")
					should have_link(test_topic.title, 
						             href: forum_topic_path(@forum, test_topic))
				end
			end
		end

		describe "last posts" do
			it { should have_content("ago") }
		end
	end
end
