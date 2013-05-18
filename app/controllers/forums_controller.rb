class ForumsController < ApplicationController

	before_filter :admin_required, :except => [:index, :show, :new, :create]

	def new
		@forum = Forum.new
	end

	def create
		@forum = Forum.new(params[:forum])
		if @forum.save
			flash[:success] = "Forum created successfully!"
			redirect_to forum_path(@forum)
		else
			render 'new'
		end
	end

	def index
		@forums = Forum.all
	end

	def show
		@forum = Forum.find(params[:id])
		@topics = @forum.topics
	end
end
