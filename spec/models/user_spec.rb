require 'spec_helper'

describe User do
  
	before do
		@user = User.new(name: "Example User", email: "user@example.com",
		                      password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:blog_posts) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:remember_token) }

	it { should be_valid }

	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end

	describe "return values of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by_email(@user.email) }

		describe "with valid password" do
			it { should == found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { should_not == user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end

	describe "when password is too short" do
		before { @user.password = @user.password_confirmation = "a" * 4 }

		it { should be_invalid }
	end

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when passwords don't match" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "when name is not present" do
		before do
			@user = User.new(name: "", email: "user@example.com")
		end
		it { should_not be_valid}
	end

	describe "when email is not present" do
		before { @user.email = " "}
		it { should_not be_valid }
	end

	describe "when email is taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it { should_not be_valid }
	end

	describe "when email is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. 
				           foo@bar_bax.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end

	describe "blog post associations" do
		before { @user.save }
		let!(:older_blog_post) do
			FactoryGirl.create(:blog_post, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_blog_post) do
			FactoryGirl.create(:blog_post, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right blog posts in the right order" do
			@user.blog_posts.should == [newer_blog_post, older_blog_post]
		end
	end
end
