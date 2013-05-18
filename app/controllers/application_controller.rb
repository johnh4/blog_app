class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include ApplicationHelper

  def admin_required  
  	unless current_user && (current_user.permission_level == 1 || current_user.id == 1)  
  		redirect_to root_path  
  	end  
  end

  def admin_or_owner_required(id)
  	unless current_user.id == id || current_user.permission_level == 1 || current_user.id == 1
  		redirect_to root_path
  	end
  end
end