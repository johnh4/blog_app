require 'spec_helper'

describe "PostPages" do

	before do
		@user = User.create(name: "John Doe", email: "jdoe@example.com", password: "password", 
						 password_confirmation: "password")
		@forum = Forum.create(name: "Test Forum 1")
		@topic = @user.topics.build(title: "Test Title 1", forum_id: @forum.id)
		@topic.save
		@post = @topic.posts.build(content: "Test Post 1")
		sign_in @user
	end

	#let(:forum) { FactoryGirl.create(:forum) }
	#let(:topic) { FactoryGirl.create(:topic, forum: forum, user: @user) }


	subject { page }

	describe "a reply link" do
		before { visit forum_topic_path(@forum, @topic) }

		it { should have_link("Reply") }

		describe "can be used" do
			before do
				click_link("Reply")
				fill_in "Content",     with: "First Reply!"
			end
			it "to make a new post" do
				expect { click_button "Post" }.to change(Post, :count).by(1)
			end
		end
	end

	describe "after making a new post" do
		before do
			visit forum_topic_path(@forum, @topic)
			click_link("Reply")
			fill_in "Content",   with: "My post."
			click_button "Post"
		end

		describe "an edit link" do
			before { visit forum_topic_path(@forum, @topic) }

			it { should have_link("Edit") }

			describe "can be used" do
				before do
					click_link("Edit")
					fill_in "Content",   with: "My Edit."
					click_button "Edit"
				end
				it "to make an edit" do
					should have_content("My Edit.")
				end
				it { should_not have_content("My post.") }
			end
		end
	end

	describe "the correct user" do
		before do
			@user_2 = User.create(name: "Smith", email: "smith@example.com", password: "password", 
						 password_confirmation: "password")
			@user_2.save
			#@post_2 = @topic.posts.build(content: "Post two.")
			#@post_2.user_id = @user_2.id
			#@post_2.save
			sign_in @user_2
			visit forum_topic_path(@forum, @topic) 
		end

		describe "should be listed as the original poster" do
			before do
				visit new_forum_topic_path(@forum)
				fill_in "post[content]", with: "My topic content."
				click_button "Create topic"
			end
			it { @user_2.id.should_not be_nil }
			it { should have_link(@user_2.name, href: user_path(@user_2)) }
		end

		describe "or the reply posting poster" do
			before do
				sign_in @user
				visit forum_topic_path(@forum,1)
				click_link "Reply"
				fill_in "Content", with: "User One reply."
				click_button "Post"
			end

			it { should have_link(@user.name, href: user_path(@user)) }
		end
	end
end
