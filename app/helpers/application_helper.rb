module ApplicationHelper

	def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
  	end

  	def store_location
    	session[:return_to] = request.url
  	end

	def admin?
		if signed_in? && (current_user.permission_level == 1 || current_user.id == 1)
			return true
		else
			return false
		end
	end

	def owner?(id)
		if current_user.id == id
			return true
		else
			return false
		end
	end

	def admin_or_owner?(id)
		if (admin? || owner?(id))
			return true
		else
			return false
		end
	end
end
