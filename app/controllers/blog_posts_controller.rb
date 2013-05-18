class BlogPostsController < ApplicationController

	before_filter :signed_in_user, except: [:show, :index]

	def new
		@blog_post = BlogPost.new(user_id: current_user.id)
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