require 'spec_helper'

describe "PostPages" do



	before do
		@user = User.create(name: "John Doe", email: "jdoe@example.com", password: "password", 
						 password_confirmation: "password")
		@forum = Forum.create(name: "Test Forum 1")
		@topic = @user.topics.build(title: "Test Title 1", forum_id: @forum.id)
		@topic.save
		#@post = @topic.posts.build(title: "Test Post 1")
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
end
