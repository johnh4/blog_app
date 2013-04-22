class CommentsController < ApplicationController

	def new
		@blog_post = BlogPost.find(params[:blog_post_id])
		@comment = Comment.new(blog_post_id: params[:blog_post_id])
		#@comment = @blog_post.comments.build(blog_post_id: @blog_post.id)
		#@blog_post = BlogPost.find(@comment.blog_post_id)
	end

	def create
		@user = User.find(params[:comment][:user_id])
		@blog_post = BlogPost.find(params[:blog_post_id])
		@comment = @user.comments.build(params[:comment])
		if @comment.save
			redirect_to [@blog_post, @comment]
			#redirect_to blog_post_comment_path(@user, @comment)
			#redirect_to '/blog_posts/:blog_post_id/comments/:id'
			#redirect_to blog_post_comment_path
		else
			render 'new'
		end
	end
	
	def index
		#@user = User.find(params[:id])
		#@blog_posts = @user.blog_posts
		@blog_post = BlogPost.find(params[:blog_post_id])
		#@users = User.all
	end

	def show
		@comment = Comment.find(params[:id])
	end

end

=begin
	def create
		@comment= Comment.new(params[:comment])
		if @comment.save
			redirect_to '/blog_posts/:blog_post_id/comments/:id'
			#redirect_to blog_post_comment_path
		else
			render 'new'
		end
	end
	
	def index
		#@user = User.find(params[:id])
		#@blog_posts = @user.blog_posts
		@blog_post = BlogPost.find(params[:blog_post_id])
		#@users = User.all
	end

	def show
		@comment = Comment.find(params[:id])
	end

end
=end