class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	@blog_posts = @user.blog_posts.paginate(page: params[:page])
    @comments = @user.comments.paginate(page: params[:page])
    @topics = @user.topics.paginate(page: params[:page])
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Blog!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end
end
