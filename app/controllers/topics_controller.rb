class TopicsController < ApplicationController

	before_filter :signed_in_user, :except => [:index, :show]
	before_filter :admin_required, :only => :destroy

	def new
		@topic = Topic.new(forum_id: params[:forum_id])
		#@topic.user = current_user
		#@topic.forum = Forum.find(params[:forum_id])
		@post = Post.new
		@forum = Forum.find(params[:forum_id])
		#@post.user = current_user
		#@post.topic = @topic
	end

	def create
		#@topic = Topic.new(title: params[:topic][:title], last_poster_id: current_user.id,
		#		               last_post_at: Time.now, 
		#		               forum_id: params[:topic][:forum_id])
		@topic = current_user.topics.build(title: params[:topic][:title], 
							   last_poster_id: current_user.id,
				               last_post_at: Time.now, 
				               forum_id: params[:topic][:forum_id])
		params[:post][:user_id] = params[:topic][:user_id]
		@post = @topic.posts.build(params[:post])
		#@post = Post.create(params[:post])
		if @topic.save
			if @post.save
				#@topic = Topic.find(@post.topic_id)  
   	 			@topic.update_attributes(:last_poster_id => current_user.id, 
   	 									 :last_post_at => Time.now)
				flash[:success] = "Successfully created topic."
				redirect_to forum_topic_path(@topic.forum_id, @topic)
				else
				redirect action: 'new'
			end
			#redirect_to forum_path(@topic.forum_id)
		else
			render 'new'
		end
	end

	def show
		@topic = Topic.find(params[:id])
	end


	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy
		flash[:success] = "Successfully destroyed topic."
		redirect_to forum_path(@topic.forum_id)
	end
end
