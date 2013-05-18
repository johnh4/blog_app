class ForumsController < ApplicationController

	before_filter :admin_required, :except => [:index, :show]

	def new
	end

	def index
		@forums = Forum.all
	end

	def show
		@forum = Forum.find(params[:id])
		@topics = @forum.topics
	end
end
