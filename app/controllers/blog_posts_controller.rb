class BlogPostsController < ApplicationController

	def new
		@blog_post = BlogPost.new
	end

	def create
		@blog_post= BlogPost.new(params[:blog_post])
		if @blog_post.save
			redirect_to @blog_post
		else
			render 'new'
		end
	end
	
	def index
		#@user = User.find(params[:id])
		#@blog_posts = @user.blog_posts
		@users = User.all
	end

	def show
		@blog_post = BlogPost.find(params[:id])

	end

end