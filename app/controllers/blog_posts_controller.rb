class BlogPostsController < ApplicationController

	before_filter :signed_in_user, except: [:show, :index]

	def new
		@blog_post = BlogPost.new(user_id: current_user.id)
	end

	def create
		@blog_post= BlogPost.new(params[:blog_post])
		if @blog_post.save
			redirect_to blog_post_comments_path(@blog_post)
		else
			render 'new'
		end
	end
	
	def index
		#@user = User.find(params[:id])
		#@blog_posts = @user.blog_posts
		@users = User.all
		@all_blog_posts = BlogPost.all
	end

	def show
		@blog_post = BlogPost.find(params[:id])
	end

	def edit
		@blog_post = BlogPost.find(params[:id])
		admin_or_owner_required(@blog_post.user.id)
	end

	def update
		@blog_post = BlogPost.find(params[:id])
		admin_or_owner_required(@blog_post.user.id)
		if @blog_post.update_attributes(params[:blog_post])
			flash[:success] = "Successfully updated blog post."
			redirect_to blog_post_comments_path(@blog_post)
		else
			render 'edit'
		end
	end

	def destroy
		@blog_post = BlogPost.find(params[:id])
		@blog_post.destroy
		flash[:success] = "Blog post successfully destroyed."
		redirect_to blog_posts_path
	end

end