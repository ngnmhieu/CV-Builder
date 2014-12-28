class UsersController < ApplicationController
  def login
    if session[:user_id]
      respond_to do |format|
        format.html { redirect_to resumes_path }
      end
      return
    end

    @user = User.new
  end

  def authenticate
    @user = User.find_by(email: login_params[:email])
    if @user.try(:authenticate, login_params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome back, #{@user.name ? @user.name : @user.email }"
      redirect_to resumes_path
      return 
    else
      respond_to do |format|
        format.html do
          flash[:notice] = "Login failed. You might have given the wrong email/password. Please try again"
          redirect_to login_path
          return
        end
      end
    end
  end
  
  def logout
    session[:user_id] = nil
    respond_to do |format|
      format.html do 
        flash[:notice] = "Successfully logged out."
        redirect_to resumes_path 
        return
      end
    end
  end

  def register
    @user = User.new
  end

  def create
    @user = User.new(register_params)

    if @user.save 
      respond_to do |format|
        format.html { redirect_to resumes_path }
      end
    else
      respond_to do |format|
        format.html { render action: 'register' }
      end
    end

  end

  def register_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
