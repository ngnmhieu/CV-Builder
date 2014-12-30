require 'active_support/concern'

module UsersMethods
  extend ActiveSupport::Concern 

  def logged_in?
    return !session[:user_id].nil? && User.find_by(id: session[:user_id])
  end

  def current_user
    if logged_in?
      return User.find_by(id: session[:user_id])
    else
      return nil
    end
  end
end
