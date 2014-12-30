class UsersController < ApplicationController
  def login
    if logged_in?
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    end

    @user = User.new
  end

  def logout
    do_logout

    respond_to do |format|
      format.html do 
        flash[:notice] = "Successfully logged out."
        redirect_to root_path 
      end
    end
  end

  def authenticate
    if @user = do_authenticate(login_params[:email], login_params[:password])
      do_login(@user.id)
      flash[:notice] = "Welcome back, #{@user.name ? @user.name : @user.email }"
      redirect_to root_path
    else
      respond_to do |format|
        format.html do
          flash[:notice] = "Login failed. You might have given the wrong email/password. Please try again"
          redirect_to login_path
        end
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
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.html { render action: 'register' }
      end
    end

  end

  private
    def do_logout
      session[:user_id] = nil
    end

    def do_login(id)
      session[:user_id] = id
    end

    def do_authenticate(email, password)
      @user = User.find_by(email: email)
      return @user.try(:authenticate, password) ? @user : false;
    end

    def register_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def login_params
      params.require(:user).permit(:email, :password)
    end
end
