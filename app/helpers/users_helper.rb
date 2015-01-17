module UsersHelper
  # check if user is logged in
  def logged_in?
    return !session[:user_id].nil? && User.find_by(id: session[:user_id])
  end

  # return the User object for current user
  # if not logged_in, then nil 
  def current_user
    return logged_in? ? User.find_by(id: session[:user_id]) : nil
  end

  def oauth_path provider
    "/auth/#{provider.to_s}"
  end
end
