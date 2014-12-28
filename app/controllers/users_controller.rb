class UsersController < ApplicationController
  def login
  end
  
  def logout
  end

  def register
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      redirect_to resumes_path
    else
      redirect_to register_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
