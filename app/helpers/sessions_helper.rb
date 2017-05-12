module SessionsHelper
	 # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id

  end
=begin
  def signed_in?
    !current_user.nil?
  end
=end

=begin
  
# Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  
=end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil    
  end

end

