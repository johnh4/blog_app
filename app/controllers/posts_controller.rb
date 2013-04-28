class PostsController < ApplicationController

	def new
		@topic = Topic.find(params[:topic_id])
		@post = Post.new
		@forum = Forum.find(params[:forum_id])
	end

	def create
	  @topic = Topic.find(params[:topic_id])  
	  @post = @topic.posts.build(:content => params[:post][:content])  
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
		@topic = Topic.find(params[:topic_id])
		@forum = Forum.find(params[:forum_id])
	end

	def update
		@topic = Topic.find(params[:topic_id])
		@post = Post.find(params[:id])
		if @post.update_attributes(params[:post])
			#@topic = Topic.find(@post.topic_id)
			@topic.update_attributes(last_poster_id: current_user.id, last_post_at: Time.now)
			flash[:notice] = "Successfully updated post."
			redirect_to [@topic.forum, @topic]
		else
			render 'edit'
		end
	end

end
