class PostsController < ApplicationController

	before_filter :signed_in_user

	def new
		@topic = Topic.find(params[:topic_id])
		@post = Post.new(user_id: current_user.id)
		@forum = Forum.find(params[:forum_id])
	end

	def create
	  @topic = Topic.find(params[:topic_id])
	  #params[:post][:user] = User.find(current_user.id)
	  #@post = @topic.posts.build(params[:post])
	  @post = @topic.posts.build(:content => params[:post][:content])  
	  #@post.user = User.find(current_user.id)
	  @post.user_id = current_user.id
	  if @post.save
	  	@topic = Topic.find(@post.topic_id)  
    	@topic.update_attributes(:last_poster_id => current_user.id, 
    							 :last_post_at => Time.now)
	    flash[:notice] = "Successfully created post."  
	    redirect_to [@topic.forum, @topic]  
	  else  
	    render :action => 'new'  
	  end  
	end

	def edit
		@post = Post.find(params[:id])
		admin_or_owner_required(@post.topic.user.id)
		@topic = Topic.find(params[:topic_id])
		@forum = Forum.find(params[:forum_id])
	end

	def update
		@topic = Topic.find(params[:topic_id])
		@post = Post.find(params[:id])
		admin_or_owner_required(@post.topic.user.id)
		if @post.update_attributes(params[:post])
			#@topic = Topic.find(@post.topic_id)
			@topic.update_attributes(last_poster_id: current_user.id, last_post_at: Time.now)
			flash[:notice] = "Successfully updated post."
			redirect_to [@topic.forum, @topic]
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		admin_or_owner_required(@post.topic.user.id)
		@post.destroy
		flash[:notice] = "Successfully destroyed post."
		redirect_to forums_path
	end

end
